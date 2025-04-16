# Define variables
HOST = your_host_dns_here  # Replace with your actual host DNS
USER = your_username_here   # Replace with your SSH username
PDF_ENGINE = xelatex
TEMPLATE = template.tex
DOCS_DIR = .

# Markdown files
REQUIREMENT_MD = Requirement_Specification.md
DESIGN_MD = Design_Specification.md

# Output files
REQUIREMENT_PDF = Requirement_Specification.pdf
REQUIREMENT_DOCX = Requirement_Specification.docx
DESIGN_PDF = Design_Specification.pdf
DESIGN_DOCX = Design_Specification.docx

# Default target
all: pdf-docx

# Create PDF and DOCX from Requirement_Specification.md
pdf-docx: $(REQUIREMENT_PDF) $(REQUIREMENT_DOCX) $(DESIGN_PDF) $(DESIGN_DOCX)

$(REQUIREMENT_PDF): $(REQUIREMENT_MD)
	pandoc $(DOCS_DIR)/$(REQUIREMENT_MD) -o $(DOCS_DIR)/$(REQUIREMENT_PDF) --from commonmark_x --template=$(TEMPLATE) --pdf-engine=$(PDF_ENGINE)

$(REQUIREMENT_DOCX): $(REQUIREMENT_MD)
	pandoc $(DOCS_DIR)/$(REQUIREMENT_MD) -o $(DOCS_DIR)/$(REQUIREMENT_DOCX) --from commonmark_x --reference-doc=$(DOCS_DIR)/org/Requirement_Specification.docx

# Create PDF and DOCX from Design_Specification.md
$(DESIGN_PDF): $(DESIGN_MD)
	pandoc $(DOCS_DIR)/$(DESIGN_MD) -o $(DOCS_DIR)/$(DESIGN_PDF) --from commonmark_x --template=$(TEMPLATE) --pdf-engine=$(PDF_ENGINE)

$(DESIGN_DOCX): $(DESIGN_MD)
	pandoc $(DOCS_DIR)/$(DESIGN_MD) -o $(DOCS_DIR)/$(DESIGN_DOCX) --from commonmark_x --reference-doc=$(DOCS_DIR)/org/Design_Specification.docx

# Copy all files to Windows system
copy:
	scp $(DOCS_DIR)/* $(USER)@$(HOST):/path/to/destination/  # Replace with your actual destination path

# Clean up generated files
clean:
	rm -f $(DOCS_DIR)/*.pdf $(DOCS_DIR)/*.docx
