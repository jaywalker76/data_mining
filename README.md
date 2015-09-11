Data Mining
===========

Working through the issue of entity resolution for massive datasets.

The point of departure is examples provided in the [Mining Massive Datasets](http://www.mmds.org/) book. Please note that the problems completed
here are not the same as those provided for the [Mining Massive Datasets MOOC](https://www.coursera.org/course/mmds). Locally sensitive hashing
seemed to be a good start. Issues arose when considering how a document
would be shingled. There would need to be a separate logic for how to
handle abbreviations, misspellings, etc.

This led to the current phase which takes a closer look at the [Dedupe](https://github.com/datamade/dedupe) Python package and the [SERF](http://infolab.stanford.edu/serf/) project. The SERF project is not ongoing so
it's being referenced from the standpoint of lessons learned. I'll also
be taking a look at [elasticsearch-entity-resolution](https://github.com/YannBrrd/elasticsearch-entity-resolution), [berkely entity resolution](https://github.com/gregdurrett/berkeley-entity), and [DistrictDataLabs](https://github.com/DistrictDataLabs/entity-resolution) as well as [Duke](https://github.com/larsga/Duke).




