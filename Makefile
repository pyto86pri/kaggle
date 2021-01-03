COMPETITION=titanic

.PHONY: join
join:
	@mkdir -p competitions/$(COMPETITION)/inputs
	@echo "Download files of competition: $(COMPETITION)"
	@KAGGLE_CONFIG_DIR=.kaggle \
	poetry run kaggle competitions download \
		-p competitions/$(COMPETITION)/inputs \
		$(COMPETITION) || \
	(echo "Accept competition rules first"; open "https://www.kaggle.com/c/$(COMPETITION)/rules"; exit 1)
	@(cd competitions/$(COMPETITION)/inputs; unzip -o $(COMPETITION).zip; rm $(COMPETITION).zip)

.PHONY: submit
submit:
	@echo "Submit for competition: $(COMPETITION)"
	@KAGGLE_CONFIG_DIR=.kaggle \
	poetry run kaggle competitions submit $(COMPETITION) \
		-f competitions/$(COMPETITION)/submissions/$(shell ls -t1 competitions/$(COMPETITION)/submissions | head -1) \
		-m ""

.PHONY: submissions
submissions:
	@KAGGLE_CONFIG_DIR=.kaggle \
	poetry run kaggle competitions submissions $(COMPETITION)
