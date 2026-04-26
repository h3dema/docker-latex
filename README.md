# Latex Container

## Using the LaTeX Build Container

This repository provides a fully containerized LaTeX build environment based on Ubuntu and a complete TeX Live installation.  
It automatically compiles the document located in `doc/` when the container starts, including bibliography support and optional package installation via `install.lst`.


### Clone the Repository

```bash
git clone git@github.com:h3dema/docker-latex.git
cd docker-latex
```


### Build the Container

The project includes a `docker-compose.yaml` file that builds the image and sets up the workspace mount.

```bash
docker-compose build
```

This step installs:

- Ubuntu base system  
- Full TeX Live distribution  
- `latexmk` for automated compilation  
- A custom entrypoint script that handles package installation and PDF generation  



### Run the Container (and compile your latex project ...)

To compile the LaTeX project inside `doc/`, simply run:

```bash
docker-compose up
```

> `doc` is the default folder for the project. 

The container will:

1. Look for `/workspace/doc/install.lst`  
   - If present, install each package listed (one per line) using `tlmgr`.
2. Determine the main LaTeX file  
   - Defaults to `main.tex`  
   - Can be overridden using the `LATEX_MAIN` environment variable:
     ```bash
     LATEX_MAIN=thesis.tex docker-compose up
     ```
3. Run `latexmk` to compile the document, including bibliography.

The resulting PDF will appear inside your local `doc/` directory.



### Directory Structure

Your repository should look like this:

```
.
├── Dockerfile
├── docker-compose.yaml
├── compile.sh
└── doc/
    ├── main.tex
    ├── references.bib
    └── install.lst   (optional)
```



### 📝 Notes

- `install.lst` is optional and allows you to install additional LaTeX packages dynamically.
- Bibliography files (`.bib`) are automatically handled by `latexmk`.
- The container always compiles the document on startup; no manual commands are required inside the container.
