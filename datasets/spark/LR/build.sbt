name := "LR"

version := "1.0"

scalaVersion := "2.12.17"

libraryDependencies ++= Seq(
    "org.apache.hadoop" % "hadoop-hdfs" % "3.3.1" % Test,
    "org.apache.spark" %% "spark-sql" % "3.3.1" % "provided",
    "org.scalanlp" %% "breeze" % "2.1.0",
)
