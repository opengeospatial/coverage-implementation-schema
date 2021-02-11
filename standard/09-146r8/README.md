## OGC 16-032r3 (19-013 on Pending Docs)

*Update Metanorma Docker image (do this once to create the image)*

`docker pull metanorma/mn:latest`



*Compile document (do this each time to compile to html)*

`docker run -v "$(pwd)":/metanorma metanorma/mn  metanorma compile -t ogc -x xml,html,doc,pdf document.adoc`
