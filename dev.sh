#!/bin/bash
# Development utilities for CV project
# Source this file to add commands to your shell:
#   source dev.sh
# Or add to your ~/.bashrc or ~/.zshrc:
#   [ -f /path/to/cv/dev.sh ] && source /path/to/cv/dev.sh

# Get the project root directory
CV_PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper function for colored output
cv_log() {
    echo -e "${GREEN}[CV]${NC} $1"
}

cv_error() {
    echo -e "${RED}[CV ERROR]${NC} $1"
}

cv_warn() {
    echo -e "${YELLOW}[CV WARN]${NC} $1"
}

cv_info() {
    echo -e "${BLUE}[CV INFO]${NC} $1"
}

# Build English PDF
cv-build-en() {
    cv_log "Building English resume..."
    cd "$CV_PROJECT_ROOT" || return 1
    sh ./scripts/build-resume.sh en
    if [ $? -eq 0 ]; then
        cv_log "✓ English resume built: resume-en.pdf"
    else
        cv_error "Failed to build English resume"
        return 1
    fi
}

# Build Spanish PDF
cv-build-es() {
    cv_log "Building Spanish resume..."
    cd "$CV_PROJECT_ROOT" || return 1
    sh ./scripts/build-resume.sh es
    if [ $? -eq 0 ]; then
        cv_log "✓ Spanish resume built: resume-es.pdf"
    else
        cv_error "Failed to build Spanish resume"
        return 1
    fi
}

# Build both PDFs
cv-build-all() {
    cv_log "Building all resumes..."
    cv-build-en && cv-build-es
    if [ $? -eq 0 ]; then
        cv_log "✓ All resumes built successfully"
    else
        cv_error "Failed to build all resumes"
        return 1
    fi
}

# Copy PDFs to website dist folder
cv-copy-pdfs() {
    cv_log "Copying PDFs to website dist..."
    cd "$CV_PROJECT_ROOT" || return 1

    if [ ! -d "website/dist" ]; then
        cv_warn "Website dist folder doesn't exist. Building website first..."
        cv-build-web
    fi

    if [ -f "resume-en.pdf" ] && [ -f "resume-es.pdf" ]; then
        cp resume-en.pdf website/dist/
        cp resume-es.pdf website/dist/
        cv_log "✓ PDFs copied to website/dist/"
    else
        cv_error "PDF files not found. Run cv-build-all first."
        return 1
    fi
}

# Run website in development mode
cv-dev-web() {
    cv_log "Starting website development server..."
    cd "$CV_PROJECT_ROOT/website" || return 1

    if [ ! -d "node_modules" ]; then
        cv_warn "Node modules not found. Installing dependencies..."
        npm install
    fi

    cv_info "Opening http://localhost:4321"
    npm run dev
}

# Build website for production
cv-build-web() {
    cv_log "Building website..."
    cd "$CV_PROJECT_ROOT/website" || return 1

    if [ ! -d "node_modules" ]; then
        cv_warn "Node modules not found. Installing dependencies..."
        npm install
    fi

    npm run build
    if [ $? -eq 0 ]; then
        cv_log "✓ Website built: website/dist/"
    else
        cv_error "Failed to build website"
        return 1
    fi
}

# Full build: PDFs + copy + website
cv-deploy() {
    cv_log "Starting full deployment build..."
    cv-build-all && cv-build-web && cv-copy-pdfs
    if [ $? -eq 0 ]; then
        cv_log "✓ Full deployment build complete!"
        cv_info "Website ready at: website/dist/"
    else
        cv_error "Deployment build failed"
        return 1
    fi
}

# Preview website build
cv-preview-web() {
    cv_log "Starting website preview server..."
    cd "$CV_PROJECT_ROOT/website" || return 1

    if [ ! -d "dist" ]; then
        cv_warn "Website not built yet. Building..."
        cv-build-web
    fi

    npm run preview
}

# Clean build artifacts
cv-clean() {
    cv_log "Cleaning build artifacts..."
    cd "$CV_PROJECT_ROOT" || return 1

    # Remove LaTeX build artifacts
    rm -rf build/
    rm -f *.aux *.log *.out

    # Remove PDFs (optional, commented out by default)
    # rm -f resume-en.pdf resume-es.pdf

    # Remove website build
    rm -rf website/dist/

    cv_log "✓ Clean complete"
}

# Install website dependencies
cv-install() {
    cv_log "Installing website dependencies..."
    cd "$CV_PROJECT_ROOT/website" || return 1
    npm install
    if [ $? -eq 0 ]; then
        cv_log "✓ Dependencies installed"
    else
        cv_error "Failed to install dependencies"
        return 1
    fi
}

# Show help
cv-help() {
    echo -e "${GREEN}CV Project Development Commands${NC}"
    echo ""
    echo -e "${BLUE}PDF Generation:${NC}"
    echo "  cv-build-en      Build English resume PDF"
    echo "  cv-build-es      Build Spanish resume PDF"
    echo "  cv-build-all     Build both English and Spanish PDFs"
    echo ""
    echo -e "${BLUE}Website:${NC}"
    echo "  cv-dev-web       Start website development server (http://localhost:4321)"
    echo "  cv-build-web     Build website for production"
    echo "  cv-preview-web   Preview production build locally"
    echo ""
    echo -e "${BLUE}Utilities:${NC}"
    echo "  cv-copy-pdfs     Copy PDFs to website/dist/ folder"
    echo "  cv-deploy        Full build: PDFs + website + copy PDFs"
    echo "  cv-install       Install website dependencies"
    echo "  cv-clean         Clean build artifacts"
    echo "  cv-help          Show this help message"
    echo ""
}

# Auto-show help when sourced
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    # Script is being sourced
    cv_log "Development commands loaded! Type ${GREEN}cv-help${NC} for available commands."
else
    # Script is being executed directly
    cv_error "This script should be sourced, not executed directly."
    echo "Usage: source dev.sh"
    exit 1
fi
