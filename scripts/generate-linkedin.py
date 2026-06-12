#!/usr/bin/env python3
"""Generate LinkedIn section files from website JSON CV data.

This keeps LinkedIn copy synchronized with the website source and applies
practical section length limits for easier paste into LinkedIn UI.
"""

from __future__ import annotations

import json
from dataclasses import dataclass
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parent.parent
DATA_DIR = ROOT / "data"
OUT_DIR = ROOT / "linkedin"


@dataclass(frozen=True)
class Limits:
    headline: int = 220
    about: int = 2600
    exp_total_per_role: int = 2000
    bullet: int = 220
    bullets_per_role: int = 4
    featured_items: int = 5


LIMITS = Limits()


def load_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def clamp(text: str, max_len: int) -> str:
    text = " ".join(text.strip().split())
    if len(text) <= max_len:
        return text
    if max_len <= 3:
        return text[:max_len]
    return text[: max_len - 3].rstrip() + "..."


def write(path: Path, content: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content.strip() + "\n", encoding="utf-8")


def build_headline(data: dict[str, Any], lang: str) -> str:
    title = data["profile"]["title"]
    focus = {
        "en": "SaaS, Fintech, E-Government",
        "es": "SaaS, Fintech y E-Government",
    }[lang]
    return clamp(f"{title} | {focus}", LIMITS.headline)


def build_about(data: dict[str, Any]) -> str:
    return clamp(data["summary"], LIMITS.about)


def build_experience(data: dict[str, Any], lang: str) -> str:
    title = "Experience" if lang == "en" else "Experiencia"
    lines = [f"# {title}", ""]

    for role in data["experience"]:
        lines.append(f"## {role['title']}")
        lines.append(f"{role['company']} | {role['location']}")
        lines.append(role["dates"])
        lines.append("")

        bullets: list[str] = []
        for bullet in role["achievements"][: LIMITS.bullets_per_role]:
            bullets.append(f"- {clamp(bullet, LIMITS.bullet)}")

        role_text = "\n".join(bullets)
        if len(role_text) > LIMITS.exp_total_per_role:
            # Keep earliest bullets and trim the last bullet if needed.
            trimmed: list[str] = []
            total = 0
            for item in bullets:
                if total + len(item) + 1 <= LIMITS.exp_total_per_role:
                    trimmed.append(item)
                    total += len(item) + 1
                else:
                    allowed = LIMITS.exp_total_per_role - total - 1
                    if allowed > 4:
                        trimmed.append(clamp(item, allowed))
                    break
            bullets = trimmed

        lines.extend(bullets)
        lines.append("")

    return "\n".join(lines).rstrip()


def build_education(data: dict[str, Any], lang: str) -> str:
    title = "Education" if lang == "en" else "Educacion"
    lines = [f"# {title}", ""]
    for edu in data["education"]:
        lines.append(f"## {edu['degree']}")
        lines.append(f"{edu['institution']} | {edu['location']}")
        lines.append(edu["dates"])
        lines.append("")
    return "\n".join(lines).rstrip()


def build_skills(data: dict[str, Any], lang: str) -> str:
    skills = data["skills"]
    if lang == "en":
        sections = [
            ("Skills", [
                ("Core", skills["core"]),
                ("Cloud and DevOps", skills["cloud"]),
                ("Leadership and Collaboration", skills["soft"]),
                ("Languages", skills["languages"]),
            ]),
        ]
    else:
        sections = [
            ("Habilidades", [
                ("Core", skills["core"]),
                ("Cloud y DevOps", skills["cloud"]),
                ("Liderazgo y Colaboracion", skills["soft"]),
                ("Idiomas", skills["languages"]),
            ]),
        ]

    main_title, groups = sections[0]
    lines = [f"# {main_title}", ""]
    for heading, value in groups:
        lines.append(f"## {heading}")
        lines.append(value)
        lines.append("")
    return "\n".join(lines).rstrip()


def build_projects_featured(data: dict[str, Any], lang: str) -> str:
    title = "Projects / Featured" if lang == "en" else "Proyectos / Destacados"
    role_label = "Role" if lang == "en" else "Rol"
    date_label = "Dates" if lang == "en" else "Fechas"

    items: list[dict[str, str]] = []

    for item in data["opensource"][:2]:
        items.append(
            {
                "name": item["title"],
                "role": item["role"],
                "dates": item["dates"],
                "url": item["url"],
                "desc": clamp(item["achievements"][0], 180),
            }
        )

    for app in data["androidapps"][: LIMITS.featured_items - len(items)]:
        items.append(
            {
                "name": app["name"],
                "role": app["role"],
                "dates": app["dates"],
                "url": app["url"],
                "desc": clamp(app["achievements"][0], 180),
            }
        )

    lines = [f"# {title}", ""]
    for item in items:
        lines.append(f"## {item['name']}")
        lines.append(f"{role_label}: {item['role']}")
        lines.append(f"{date_label}: {item['dates']}")
        lines.append(f"URL: {item['url']}")
        lines.append(f"- {item['desc']}")
        lines.append("")

    return "\n".join(lines).rstrip()


def render_language(data: dict[str, Any], lang: str) -> dict[str, str]:
    return {
        "headline.txt": build_headline(data, lang),
        "about.md": build_about(data),
        "experience.md": build_experience(data, lang),
        "education.md": build_education(data, lang),
        "skills.md": build_skills(data, lang),
        "projects-featured.md": build_projects_featured(data, lang),
    }


def write_limits_report(en_files: dict[str, str], es_files: dict[str, str]) -> None:
    report = [
        "# LinkedIn Section Limits",
        "",
        "Configured limits used by scripts/generate-linkedin.py:",
        f"- Headline: {LIMITS.headline} chars",
        f"- About: {LIMITS.about} chars",
        f"- Experience description per role: {LIMITS.exp_total_per_role} chars",
        f"- Bullet length: {LIMITS.bullet} chars",
        f"- Bullets per role: {LIMITS.bullets_per_role}",
        f"- Featured project count: {LIMITS.featured_items}",
        "",
        "Generated content lengths:",
    ]

    for lang, files in (("en", en_files), ("es", es_files)):
        report.append(f"- {lang}:")
        for filename, content in files.items():
            report.append(f"  - {filename}: {len(content)} chars")

    write(OUT_DIR / "LIMITS.md", "\n".join(report))


def main() -> None:
    en_data = load_json(DATA_DIR / "cv-en.json")
    es_data = load_json(DATA_DIR / "cv-es.json")

    en_files = render_language(en_data, "en")
    es_files = render_language(es_data, "es")

    for filename, content in en_files.items():
        write(OUT_DIR / "en" / filename, content)
    for filename, content in es_files.items():
        write(OUT_DIR / "es" / filename, content)

    write_limits_report(en_files, es_files)


if __name__ == "__main__":
    main()
