name := "ALS"

version := "1.0"

scalaVersion := "2.12.17"

libraryDependencies ++= Seq(
    "org.apache.spark" %% "spark-sql" % "3.3.1" % "provided",
)
