# Don't actually run this.
#
# These were the steps you used to build Duke for testing purposes.

git clone https://github.com/larsga/Duke.git

cd Duke

mvn test
mvn clean package 

cp duke-dist/target/duke-dist-1.3-SNAPSHOT-bin.zip ~/Downloads/

java -cp "/home/tbonza/Downloads/duke-dist-1.3-SNAPSHOT/lib/*" no.priv.garshol.duke.Duke
