Data Mining
===========

Working through the issue of entity resolution for massive datasets.

The point of departure is examples provided in the [Mining Massive Datasets](http://www.mmds.org/) book. Please note that the problems completed
here are not the same as those provided for the [Mining Massive Datasets MOOC](https://www.coursera.org/course/mmds). Locally sensitive hashing
seemed to be a good start. Issues arose when considering how a document
would be shingled. There would need to be a separate logic for how to
handle abbreviations, misspellings, etc.

This led to an exploration phase which takes a closer look at the [Dedupe](https://github.com/datamade/dedupe) Python package and the [SERF](http://infolab.stanford.edu/serf/) project. The SERF project is not ongoing so
it's being referenced from the standpoint of lessons learned. I'll also
be taking a look at [elasticsearch-entity-resolution](https://github.com/YannBrrd/elasticsearch-entity-resolution), [berkely entity resolution](https://github.com/gregdurrett/berkeley-entity), and [DistrictDataLabs](https://github.com/DistrictDataLabs/entity-resolution) as well as [Duke](https://github.com/larsga/Duke).

After a review of the previous options, I tried building a command line tool
for [Duke](https://github.com/larsga/Duke) and trying it out with some
dummy data. My personal experience was one where I was only able to get one of
the examples to work. This was after spending a day writing a Python script to
fix the csv files in their example-data folder. When the genetic algorithm ran,
using the example data, it returned an incorrect output. Given that I was able
to run none of the examples, I didn't feel comfortable putting more time into
that project.

So, attempt #3. I'm going to try a combination of Mahout & Lucene. Hopefully
that will get some traction. See the `dedupe` folder for that project.




