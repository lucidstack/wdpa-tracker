defmodule WdpaImporterTest do
  use WdpaImporter.Test.Setup
  import WdpaImporter
  alias WdpaModels.{ProtectedArea, Country, WdpaRelease, Designation}

  doctest WdpaImporter

  test "run(path, nil) creates 2 protected areas and wdpa_release" do
    run("2-pas/year-1997", nil)

    assert 2 == ProtectedArea |> select([p], count(p.id)) |> Repo.one
    assert "WDPA_1997" == WdpaRelease |> select([r], r.name) |> Repo.one
  end

  test "run(path, nil) connects the pas to the release" do
    run("2-pas/year-1997", nil)

    [wdpa_release | _] = ProtectedArea
    |> preload(:wdpa_releases)
    |> limit(1)
    |> Repo.one
    |> Map.get(:wdpa_releases)

    assert "WDPA_1997" == wdpa_release.name
  end

  test "run(path, nil) adds the release to exiting ones" do
    existing_release = %WdpaRelease{name: "WDPA_1996"} |> Repo.insert!

    %ProtectedArea{wdpa_id: 1}
    |> Repo.insert!
    |> build_assoc(:protected_areas_in_wdpa_release, wdpa_release: existing_release)
    |> Repo.insert!

    run("2-pas/year-1997", nil)

    wdpa_releases = ProtectedArea
    |> where([pa], pa.wdpa_id == 1)
    |> preload(:wdpa_releases)
    |> Repo.one
    |> Map.get(:wdpa_releases)

    assert ["WDPA_1996", "WDPA_1997"] == wdpa_releases |> Enum.map(&(&1.name))
  end

  test "run(path, nil) creates countries" do
    run("2-countries/year-1997", nil)
    assert ["CIV", "DEU"] == Country |> select([c], c.iso3) |> Repo.all
  end

  test "run(path, nil) doesn't duplicate countries" do
    run("2-countries-dup/year-1997", nil)

    assert ["CIV"] == Country |> select([c], c.iso3) |> Repo.all
    assert 1 == Country |> select([c], count(c.id)) |> Repo.one
  end

  test "run(path, nil) creates designations" do
    run("2-designations/year-1997", nil)

    assert [
      "National Park", "Grand Hotel"
    ] == Designation |> select([d], d.name) |> Repo.all
  end

  test "run(path, nil) doesn't duplicate designations" do
    run("2-designations-dup/year-1997", nil)

    assert ["National Park"] == Designation |> select([d], d.name) |> Repo.all
    assert 1 == Designation |> select([d], count(d.id)) |> Repo.one
  end

  test "run(path, nil) skips designation if type is omitted" do
    run("designation-no-type/year-1997", nil)

    assert 1 == ProtectedArea |> select([pa], count(pa.id)) |> Repo.one
    assert 0 == Designation   |> select([d], count(d.id))   |> Repo.one
  end

  test "run(path, wdpa_release) assigns wdpa_release to the pas" do
    existing_release = %WdpaRelease{name: "WDPA_2016"} |> Repo.insert!
    run("release-given/whatever.csv", existing_release)

    [release] = ProtectedArea
    |> preload(:wdpa_releases)
    |> Repo.one
    |> Map.get(:wdpa_releases)

    assert "WDPA_2016" == release.name
  end
end
