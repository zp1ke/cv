# Website Deployment

This directory contains the Astro-based static website for the CV, deployed to GitHub Pages.

## Local Development

1. **Install dependencies:**
   ```bash
   cd website
   npm install
   ```

2. **Run development server:**
   ```bash
   npm run dev
   ```

   Visit http://localhost:4321 to see the website.

3. **Build for production:**
   ```bash
   npm run build
   ```

## Deployment

The website is automatically deployed to GitHub Pages when you push to the `master` branch.

### GitHub Pages Setup (First Time Only)

1. Go to your repository on GitHub
2. Navigate to **Settings** → **Pages**
3. Under **Source**, select **GitHub Actions**
4. The workflow will automatically deploy on the next push

### Custom Domain Setup

To use your custom domain:

1. **Add CNAME file** (create `website/public/CNAME`):
   ```
   yourdomain.com
   ```

2. **Update `astro.config.mjs`**:
   ```js
   export default defineConfig({
     site: 'https://yourdomain.com',
     base: '/',  // Change from '/cv' to '/'
     // ... rest of config
   });
   ```

3. **Configure DNS records** at your domain provider:

   **Option A - Apex domain (yourdomain.com):**
   ```
   Type: A
   Name: @
   Value: 185.199.108.153

   Type: A
   Name: @
   Value: 185.199.109.153

   Type: A
   Name: @
   Value: 185.199.110.153

   Type: A
   Name: @
   Value: 185.199.111.153
   ```

   **Option B - Subdomain (cv.yourdomain.com):**
   ```
   Type: CNAME
   Name: cv
   Value: zp1ke.github.io
   ```

4. **Enable custom domain in GitHub:**
   - Go to **Settings** → **Pages**
   - Under **Custom domain**, enter your domain
   - Check **Enforce HTTPS** (wait a few minutes for certificate)

5. **Commit and push changes:**
   ```bash
   git add website/public/CNAME website/astro.config.mjs
   git commit -m "Configure custom domain"
   git push
   ```

## Content Updates

The canonical source of CV content is:

- **English content:** `data/cv-en.json`
- **Spanish content:** `data/cv-es.json`

### Syncing with LaTeX CV

When you update CV content, update JSON first and then propagate those changes to the other outputs.

**Workflow:**
1. Update `data/cv-en.json` and/or `data/cv-es.json`
2. Mirror changes in LaTeX files under `latex/resume/en/` and/or `latex/resume/es/`
3. Regenerate LinkedIn content: `python3 scripts/generate-linkedin.py`
4. Update `latex/resume/infojobs.md` when Spanish/profile-facing content changed
5. Commit all related changes together
6. Push to trigger automatic deployment

## Project Structure

```
website/
├── public/           # Static assets (PDFs, favicon, CNAME)
├── src/
│   ├── components/   # Reusable Astro components
│   ├── layouts/      # Page layouts
│   └── pages/        # Routes (index = English, es/index = Spanish)
├── astro.config.mjs  # Astro configuration
├── package.json      # Dependencies
└── tsconfig.json     # TypeScript config
```

Shared content source (repository root):

```
data/
├── cv-en.json
└── cv-es.json
```

## Features

- 📱 **Responsive design** - Works on all devices
- 🌍 **Bilingual** - English and Spanish versions
- 📥 **PDF downloads** - Direct links to LaTeX-generated PDFs
- ⚡ **Fast loading** - Static site generation with minimal JavaScript
- 🎨 **Clean design** - Professional, minimal aesthetic
- 🖨️ **Print-friendly** - Hides download buttons and navigation when printing

## Troubleshooting

**Build fails:**
- Check that all JSON files are valid (no trailing commas, proper quotes)
- Ensure Node.js version is 18 or higher

**PDFs not showing:**
- Verify PDFs were built successfully in `latex/output/`
- Check GitHub Actions logs for PDF build errors

**Custom domain not working:**
- Verify DNS records are correct and propagated (use https://dnschecker.org)
- Ensure CNAME file matches your domain exactly
- Wait up to 48 hours for DNS propagation
- Check GitHub Pages settings show your domain as verified
