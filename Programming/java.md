## PKIX path building failed: SunCertPathBuilderException: unable to find valid certification path to requested target.

http://magicmonster.com/kb/prg/java/ssl/pkix_path_building_failed.html

Для IntelliJ Idea треба визначити який JRE використовується. Наприклад, c:\Program Files\Java\jdk1.8.0_144\jre\

Тоді потрібно імпортувати сертифікат в c:\Program Files\Java\jdk1.8.0_144\jre\lib\security\cacerts

Наприклад:

```
"c:\Program Files\Java\jre1.8.0_144\bin\keytool.exe" -import -alias example -keystore  "c:\Program Files\Java\jdk1.8.0_144\jre\lib\security\cacerts" -file d:\Temp\20171215\initializr.cer
```



