#!/usr/bin/env python3
"""Generate InfoJobs profile content from canonical CV JSON data.

This keeps InfoJobs output synchronized with data/cv-es.json and makes
InfoJobs a standalone derived output, independent from LaTeX sources.
"""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parent.parent
DATA_FILE = ROOT / "data" / "cv-es.json"
OUT_FILE = ROOT / "infojobs" / "es" / "profile.md"


def load_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def write(path: Path, content: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content.strip() + "\n", encoding="utf-8")


def profile_block(data: dict[str, Any]) -> list[str]:
    p = data["profile"]
    return [
        "## Datos Personales / Encabezado",
        f"**Nombre:** {p['name']}",
        f"**Titular:** {p['title']}",
        f"**Ubicacion:** {p['location']}",
        f"**Email:** {p['email']}",
        f"**Telefono:** {p['phone']}",
        f"**LinkedIn:** https://linkedin.com/in/{p['linkedin']}",
        f"**GitHub:** https://github.com/{p['github']}",
        "**Sitio Web:** https://sp1ke.dev",
        "",
    ]


def summary_block(data: dict[str, Any]) -> list[str]:
    return [
        "## Extracto / Presentacion",
        data["summary"],
        "",
    ]


def experience_block(data: dict[str, Any]) -> list[str]:
    lines = ["## Experiencia", ""]
    for role in data["experience"]:
        lines.extend(
            [
                f"### {role['title']}",
                f"**Empresa:** {role['company']}",
                f"**Ubicacion:** {role['location']}",
                f"**Fechas:** {role['dates']}",
                "**Descripcion:**",
            ]
        )
        lines.extend([f"- {item}." if not item.endswith(".") else f"- {item}" for item in role["achievements"]])
        lines.append("")
    return lines


def education_block(data: dict[str, Any]) -> list[str]:
    lines = ["## Estudios / Formacion", ""]
    for edu in data["education"]:
        lines.extend(
            [
                f"### {edu['degree']}",
                f"**Institucion:** {edu['institution']}",
                f"**Ubicacion:** {edu['location']}",
                f"**Fechas:** {edu['dates']}",
                "",
            ]
        )
    return lines


def skills_block(data: dict[str, Any]) -> list[str]:
    s = data["skills"]
    return [
        "## Conocimientos / Habilidades",
        f"- **Core:** {s['core']}",
        f"- **Cloud/DevOps:** {s['cloud']}",
        f"- **Soft Skills:** {s['soft']}",
        "",
        "## Idiomas",
        "- **Español:** Nativo",
        "- **Inglés:** Profesional",
        "",
    ]


def projects_block(data: dict[str, Any]) -> list[str]:
    lines = [
        "## Proyectos Adicionales / Open Source / Apps",
        "(Puede ir en la seccion de Proyectos o en el portfolio)",
        "",
    ]

    for app in data["androidapps"]:
        lines.extend(
            [
                f"**{app['name']} ({app['dates']})**",
                app["url"],
            ]
        )
        lines.extend([f"- {item}." if not item.endswith(".") else f"- {item}" for item in app["achievements"]])
        lines.append("")

    for item in data["opensource"]:
        lines.extend(
            [
                f"**{item['title']} ({item['dates']})**",
                item["url"],
            ]
        )
        lines.extend([f"- {ach}." if not ach.endswith(".") else f"- {ach}" for ach in item["achievements"]])
        lines.append("")

    return lines


def render(data: dict[str, Any]) -> str:
    parts: list[str] = [
        "# CV para InfoJobs",
        "",
        "Este archivo se genera desde data/cv-es.json.",
        "No editar manualmente: usar scripts/generate-infojobs.py.",
        "",
    ]

    parts.extend(profile_block(data))
    parts.extend(summary_block(data))
    parts.extend(experience_block(data))
    parts.extend(education_block(data))
    parts.extend(skills_block(data))
    parts.extend(projects_block(data))
    return "\n".join(parts).rstrip()


def main() -> None:
    data = load_json(DATA_FILE)
    write(OUT_FILE, render(data))


if __name__ == "__main__":
    main()