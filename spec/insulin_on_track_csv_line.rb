require 'insulin'

describe Insulin::OnTrackCsvLine do
  csv = Insulin::OnTrackCsvLine.new %q{199,"Jun 22, 2012 8:01:39 AM",Glucose,,Breakfast,5.7,""} 

  it "get serial" do
    csv["serial"].should == 199
  end

  it "get time" do
    csv["time"].should == "08:01:39 BST"
  end

  it "get date" do
    csv["date"].should == "2012-06-22"
  end

  it "get type" do
    csv["type"].should == "glucose"
  end

  it "get subtype" do
    csv["subtype"].should == nil
  end

  it "get tag" do
    csv["tag"].should == "breakfast"
  end

  it "get value" do
    csv["value"].should == 5.7
  end

  it "get notes" do
    csv["notes"].should == nil
  end

  csv_with_note = Insulin::OnTrackCsvLine.new %q{266,"Jun 28, 2012 10:21:05 AM",Medication,Humalog,After Breakfast,4.0,"F:2 bacon, 2 toast
N:test note
X:fail note
N:other note"}

  it "get subtype" do
    csv_with_note["subtype"].should == "humalog"
  end

  it "get day" do
    csv_with_note["day"].should == "thursday"
  end

  it "get unixtime" do
    csv_with_note["unixtime"].should == 1340875265
  end

  it "get notes" do
    csv_with_note["notes"].should == {
      "food" => [
        "2 bacon",
        "2 toast"
      ],
      "note" => [
        "test note",
        "other note"
      ]
    }
  end
end
