COMPETITION=titanic

.PHONY: join
join:
	mkdir -p competitions/$(COMPETITION)/files
	KAGGLE_CONFIG_DIR=.kaggle \
	poetry run kaggle competitions download \
		-p competitions/$(COMPETITION)/files \
		$(COMPETITION) || \
	(open "https://www.kaggle.com/c/$(COMPETITION)/rules"; exit 1)
	(cd competitions/$(COMPETITION)/files; unzip -o $(COMPETITION).zip; rm $(COMPETITION).zip)

.PHONY: submit
submit:
	KAGGLE_CONFIG_DIR=.kaggle \
	poetry run kaggle competitions submit $(COMPETITION) \
		-f competitions/$(COMPETITION)/submissions/$(shell ls -t1 competitions/$(COMPETITION)/submissions | head -1) \
		-m ""

.PHONY: submissions
submissions:
	KAGGLE_CONFIG_DIR=.kaggle \
	poetry run kaggle competitions submissions $(COMPETITION)
