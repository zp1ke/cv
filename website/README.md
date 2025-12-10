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

The website content is maintained separately from the LaTeX CV:

- **English content:** `website/src/data/cv-en.json`
- **Spanish content:** `website/src/data/cv-es.json`

### Syncing with LaTeX CV

When you update your LaTeX CV, remember to also update the corresponding JSON files. This is a manual process to give you full control over web presentation.

**Workflow:**
1. Update LaTeX files in `resume/en/` or `resume/es/`
2. Update corresponding JSON in `website/src/data/cv-en.json` or `cv-es.json`
3. Commit both changes together
4. Push to trigger automatic deployment

## Project Structure

```
website/
├── public/           # Static assets (PDFs, favicon, CNAME)
├── src/
│   ├── components/   # Reusable Astro components
│   ├── data/         # CV content in JSON format
│   ├── layouts/      # Page layouts
│   └── pages/        # Routes (index = English, es/index = Spanish)
├── astro.config.mjs  # Astro configuration
├── package.json      # Dependencies
└── tsconfig.json     # TypeScript config
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
- Verify PDFs were built successfully in the root directory
- Check GitHub Actions logs for PDF build errors

**Custom domain not working:**
- Verify DNS records are correct and propagated (use https://dnschecker.org)
- Ensure CNAME file matches your domain exactly
- Wait up to 48 hours for DNS propagation
- Check GitHub Pages settings show your domain as verified
