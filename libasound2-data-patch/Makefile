all:
	@echo "copy files needed ..."
	@cp -a ../../pulseaudio/install/usr/share/alsa alsa
	@echo "apply patches ..."
	@./patch-libasound2-data.sh

install:
	@mkdir -p $(DESTDIR)/usr/share/
	@cp -a alsa $(DESTDIR)/usr/share/

clean:
	@echo "remove files"
	@rm -rf alsa
