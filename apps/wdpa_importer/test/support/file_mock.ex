defmodule WdpaImporter.Test.FileMock do
  def stream!("2-pas/year-1997") do
    ["WDPAID,ISO3", "1,CIV", "2,CIV"]
  end

  def stream!("2-countries/year-1997") do
    ["WDPAID,ISO3", "1,CIV", "2,DEU"]
  end

  def stream!("2-countries-dup/year-1997") do
    ["WDPAID,ISO3", "1,CIV", "2,CIV"]
  end

  def stream!("2-designations/year-1997") do
    ["WDPAID,ISO3,DESIG_ENG,DESIG_TYPE", "1,CIV,National Park,National", "2,DEU,Grand Hotel,International"]
  end

  def stream!("2-designations-dup/year-1997") do
    ["WDPAID,ISO3,DESIG_ENG,DESIG_TYPE", "1,CIV,National Park,National", "2,CIV,National Park,National"]
  end

  def stream!("designation-no-type/year-1997") do
    ["WDPAID,ISO3,DESIG_ENG", "1,CIV,National Park"]
  end

  def stream!("release-given/whatever.csv") do
    ["WDPAID,ISO3,DESIG_ENG,DESIG_TYPE", "1,CIV,National Park,National"]
  end
end
