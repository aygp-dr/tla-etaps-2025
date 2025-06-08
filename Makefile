.PHONY: help download download-slides download-recordings download-all clean generate-summaries

# Conference URLs and directories
CONF_URL = https://conf.tlapl.us/2025-etaps/
DOWNLOADS_DIR = downloads
SLIDES_DIR = $(DOWNLOADS_DIR)/slides
VIDEOS_DIR = $(DOWNLOADS_DIR)/videos

# Files to track downloads (not committed to repo)
SLIDES = $(SLIDES_DIR)/nagendra-slides.pdf \
         $(SLIDES_DIR)/hackett-slides.pdf \
         $(SLIDES_DIR)/di-fatta-slides.pdf \
         $(SLIDES_DIR)/laufer-slides.pdf \
         $(SLIDES_DIR)/filali-slides.pdf \
         $(SLIDES_DIR)/demirbas-slides.pdf \
         $(SLIDES_DIR)/davis-slides.pdf \
         $(SLIDES_DIR)/helwer-slides.odp

VIDEOS = $(VIDEOS_DIR)/nagendra.mp4 \
         $(VIDEOS_DIR)/hackett.mp4 \
         $(VIDEOS_DIR)/di-fatta.mp4 \
         $(VIDEOS_DIR)/di-fatta-qa.mp4 \
         $(VIDEOS_DIR)/laufer.mp4 \
         $(VIDEOS_DIR)/filali.mp4 \
         $(VIDEOS_DIR)/demirbas.mp4 \
         $(VIDEOS_DIR)/davis.mp4 \
         $(VIDEOS_DIR)/helwer.mp4

ABSTRACTS = $(SLIDES_DIR)/nagendra.pdf \
            $(SLIDES_DIR)/hackett.pdf \
            $(SLIDES_DIR)/di-fatta.pdf \
            $(SLIDES_DIR)/laufer.pdf \
            $(SLIDES_DIR)/filali.pdf \
            $(SLIDES_DIR)/demirbas.pdf \
            $(SLIDES_DIR)/davis.txt \
            $(SLIDES_DIR)/helwer.txt

# Default target
help:
	@echo "TLA+ Conference Materials Downloader"
	@echo ""
	@echo "Available targets:"
	@echo "  download           - Alias for download-slides (download slides only)"
	@echo "  download-slides    - Download all slides and abstracts"
	@echo "  download-recordings - Download all video recordings"
	@echo "  download-all       - Download all materials (slides, abstracts, and videos)"
	@echo "  generate-summaries - Extract text from PDFs using pdftotext (if available)"
	@echo "  clean              - Remove all downloaded files"
	@echo ""
	@echo "Downloaded files will be stored in the $(DOWNLOADS_DIR) directory."
	@echo "These files are not committed to the repository."

# Directory targets (directories are already in git with .gitkeep files)
# These are kept as order-only prerequisites for download targets

# Alias for download-slides
download: download-slides

# Download slides and abstracts
download-slides: $(SLIDES) $(ABSTRACTS)
	@echo "All slides and abstracts downloaded to $(SLIDES_DIR)"

# Download recordings using yt-dlp
download-recordings: $(VIDEOS)
	@echo "All recordings downloaded to $(VIDEOS_DIR)"

# Download everything
download-all: download-slides download-recordings
	@echo "All conference materials downloaded to $(DOWNLOADS_DIR)"

# Generate summaries by copying text files
generate-summaries: download-slides
	@echo "Generating summaries by copying text files..."
	@mkdir -p $(DOWNLOADS_DIR)/summaries
	@for txt in $(SLIDES_DIR)/*.txt; do \
		if [ -f "$$txt" ]; then \
			cp "$$txt" "$(DOWNLOADS_DIR)/summaries/"; \
			echo "Copied $$(basename $$txt)"; \
		fi; \
	done
	@echo "Text file summaries available in $(DOWNLOADS_DIR)/summaries/"

# Clean up downloaded files
clean:
	rm -rf $(DOWNLOADS_DIR)/*
	@find $(DOWNLOADS_DIR) -type d -empty -delete 2>/dev/null || true
	@find $(DOWNLOADS_DIR) -not -name ".gitkeep" -not -path "*/\.*" -delete 2>/dev/null || true

# Individual slide downloads
$(SLIDES_DIR)/nagendra-slides.pdf:
	wget -O $@ $(CONF_URL)nagendra-slides.pdf || touch $@

$(SLIDES_DIR)/hackett-slides.pdf:
	wget -O $@ $(CONF_URL)hackett-slides.pdf || touch $@

$(SLIDES_DIR)/di-fatta-slides.pdf:
	wget -O $@ $(CONF_URL)di-fatta-slides.pdf || touch $@

$(SLIDES_DIR)/laufer-slides.pdf:
	wget -O $@ $(CONF_URL)laufer-slides.pdf || touch $@

$(SLIDES_DIR)/filali-slides.pdf:
	wget -O $@ $(CONF_URL)filali-slides.pdf || touch $@

$(SLIDES_DIR)/demirbas-slides.pdf:
	wget -O $@ $(CONF_URL)demirbas-slides.pdf || touch $@

$(SLIDES_DIR)/davis-slides.pdf:
	wget -O $@ $(CONF_URL)davis-slides.pdf || touch $@

$(SLIDES_DIR)/helwer-slides.odp:
	wget -O $@ $(CONF_URL)helwer-slides.odp || touch $@

# Individual abstract downloads
$(SLIDES_DIR)/nagendra.pdf:
	wget -O $@ $(CONF_URL)nagendra.pdf || touch $@

$(SLIDES_DIR)/hackett.pdf:
	wget -O $@ $(CONF_URL)hackett.pdf || touch $@

$(SLIDES_DIR)/di-fatta.pdf:
	wget -O $@ $(CONF_URL)di-fatta.pdf || touch $@

$(SLIDES_DIR)/laufer.pdf:
	wget -O $@ $(CONF_URL)laufer.pdf || touch $@

$(SLIDES_DIR)/filali.pdf:
	wget -O $@ $(CONF_URL)filali.pdf || touch $@

$(SLIDES_DIR)/demirbas.pdf:
	wget -O $@ $(CONF_URL)demirbas.pdf || touch $@

$(SLIDES_DIR)/davis.txt:
	wget -O $@ $(CONF_URL)davis.txt || touch $@

$(SLIDES_DIR)/helwer.txt:
	wget -O $@ $(CONF_URL)helwer.txt || touch $@

# Individual video downloads
$(VIDEOS_DIR)/nagendra.mp4:
	yt-dlp -o $@ https://youtu.be/DO8MvouV29M || touch $@

$(VIDEOS_DIR)/hackett.mp4:
	yt-dlp -o $@ https://youtu.be/MLvLQ4p9je4 || touch $@

$(VIDEOS_DIR)/di-fatta.mp4:
	yt-dlp -o $@ https://youtu.be/0A5qMWvFgdI || touch $@

$(VIDEOS_DIR)/di-fatta-qa.mp4:
	yt-dlp -o $@ https://youtu.be/NgYIS02EUnI || touch $@

$(VIDEOS_DIR)/laufer.mp4:
	yt-dlp -o $@ https://youtu.be/726oDQQRxBQ || touch $@

$(VIDEOS_DIR)/filali.mp4:
	yt-dlp -o $@ https://youtu.be/6mTGeNVkKZo || touch $@

$(VIDEOS_DIR)/demirbas.mp4:
	yt-dlp -o $@ https://youtu.be/fIWUo4gzvNE || touch $@

$(VIDEOS_DIR)/davis.mp4:
	yt-dlp -o $@ https://youtu.be/Wekywox2Ghk || touch $@

$(VIDEOS_DIR)/helwer.mp4:
	yt-dlp -o $@ https://youtu.be/KrhZebeRn90 || touch $@