# Change Log

## PENDING

**Maintenance:**

- Upgrade Ruby to 2.6.5
- Upgrade Ruby Gems for security purposes
- Update documentation to reflect
- Remove deprecated feature tests that caused testing to fail after upgrades (amazon products)

## [2.7.0](https://github.com/hurricane-response/florence-api/tree/2.7.0) (2018-10-25)

[Full Changelog](https://github.com/hurricane-response/florence-api/compare/2.6.3...2.7.0)

**Implemented enhancements:**

- Enhancements for Unarchive [\#56](https://github.com/hurricane-response/florence-api/issues/56)
- Feature: Delete Shelter in Admin UI [\#54](https://github.com/hurricane-response/florence-api/issues/54)
- Feature: add geoJSON endpoints [\#44](https://github.com/hurricane-response/florence-api/issues/44)
- Adding functionality to view trashed items and restore them when needed. [\#68](https://github.com/hurricane-response/florence-api/pull/68) ([omnilord](https://github.com/omnilord))
- Menu cleanup [\#43](https://github.com/hurricane-response/florence-api/pull/43) ([omnilord](https://github.com/omnilord))

**Fixed bugs:**

- Imports create duplicates if existing data is archived [\#59](https://github.com/hurricane-response/florence-api/issues/59)

**Closed issues:**

- Feature: ability to mark a shelter updated/current [\#63](https://github.com/hurricane-response/florence-api/issues/63)
- SemVer [\#60](https://github.com/hurricane-response/florence-api/issues/60)

**Merged pull requests:**

- Add GeoJSON endpoints for shelters and distribution points [\#70](https://github.com/hurricane-response/florence-api/pull/70) ([nihonjinrxs](https://github.com/nihonjinrxs))
- update changelog [\#67](https://github.com/hurricane-response/florence-api/pull/67) ([miklb](https://github.com/miklb))
- fix travis script [\#66](https://github.com/hurricane-response/florence-api/pull/66) ([miklb](https://github.com/miklb))
- Make the app workflow more user friendly for updating and moving resources in and out of archives [\#65](https://github.com/hurricane-response/florence-api/pull/65) ([omnilord](https://github.com/omnilord))
- Better control of deduplication through Deleting resources via UI and finer import logic [\#64](https://github.com/hurricane-response/florence-api/pull/64) ([omnilord](https://github.com/omnilord))

## [2.6.3](https://github.com/hurricane-response/florence-api/tree/2.6.3) (2018-10-13)
[Full Changelog](https://github.com/hurricane-response/florence-api/compare/2.6.2...2.6.3)

## [2.6.2](https://github.com/hurricane-response/florence-api/tree/2.6.2) (2018-10-13)
[Full Changelog](https://github.com/hurricane-response/florence-api/compare/2.6.1...2.6.2)

## [2.6.1](https://github.com/hurricane-response/florence-api/tree/2.6.1) (2018-10-13)
[Full Changelog](https://github.com/hurricane-response/florence-api/compare/2.6.0...2.6.1)

**Closed issues:**

- Backups [\#57](https://github.com/hurricane-response/florence-api/issues/57)
- Backfill separate address field data \(`city`, `state`, `zip`\) from `address` field [\#27](https://github.com/hurricane-response/florence-api/issues/27)
- Export as KML [\#1](https://github.com/hurricane-response/florence-api/issues/1)

**Merged pull requests:**

- chore: update travis deploy script [\#62](https://github.com/hurricane-response/florence-api/pull/62) ([miklb](https://github.com/miklb))

## [2.6.0](https://github.com/hurricane-response/florence-api/tree/2.6.0) (2018-10-12)
[Full Changelog](https://github.com/hurricane-response/florence-api/compare/2.5.0...2.6.0)

**Closed issues:**

- Address value format inconsistencies [\#53](https://github.com/hurricane-response/florence-api/issues/53)
- Easier Editing for Closing Shelters [\#49](https://github.com/hurricane-response/florence-api/issues/49)
- Archived list commands not correct [\#46](https://github.com/hurricane-response/florence-api/issues/46)
- UI to Re-Activate PODS [\#40](https://github.com/hurricane-response/florence-api/issues/40)
- Allow null on phone number for PODS [\#39](https://github.com/hurricane-response/florence-api/issues/39)
- update dependencies [\#31](https://github.com/hurricane-response/florence-api/issues/31)
- Feature Request: add POD \(point of distribution\) [\#29](https://github.com/hurricane-response/florence-api/issues/29)

**Merged pull requests:**

- Reverse GeoCoding for models missing required address fields. [\#58](https://github.com/hurricane-response/florence-api/pull/58) ([omnilord](https://github.com/omnilord))
- Adding FEMA import [\#55](https://github.com/hurricane-response/florence-api/pull/55) ([omnilord](https://github.com/omnilord))
- Updating the way data tables are render to make them DRY [\#52](https://github.com/hurricane-response/florence-api/pull/52) ([omnilord](https://github.com/omnilord))
- fixed some typos in readme.md [\#51](https://github.com/hurricane-response/florence-api/pull/51) ([Gotham13121997](https://github.com/Gotham13121997))
- Resolve Issue \#46 - Archive/Unarchive links [\#48](https://github.com/hurricane-response/florence-api/pull/48) ([omnilord](https://github.com/omnilord))
- A quick refactor to make some of the source easier to navigate. [\#45](https://github.com/hurricane-response/florence-api/pull/45) ([omnilord](https://github.com/omnilord))
- Add archived items views \[dependent on PR \#45\] [\#42](https://github.com/hurricane-response/florence-api/pull/42) ([omnilord](https://github.com/omnilord))
- Allowing phone numbers to be blank if not provided. \[dependent on PR \#45\] [\#41](https://github.com/hurricane-response/florence-api/pull/41) ([omnilord](https://github.com/omnilord))
- Update README to include Distribution Points API [\#38](https://github.com/hurricane-response/florence-api/pull/38) ([nihonjinrxs](https://github.com/nihonjinrxs))
- New DistributionPoints feature [\#37](https://github.com/hurricane-response/florence-api/pull/37) ([nihonjinrxs](https://github.com/nihonjinrxs))
- Bumped to latest patch of Rails 5.1 [\#36](https://github.com/hurricane-response/florence-api/pull/36) ([nihonjinrxs](https://github.com/nihonjinrxs))
- \[Depends on \#34\] Fix tests \(and production API 500 errors, too! Yikes!\) [\#35](https://github.com/hurricane-response/florence-api/pull/35) ([nihonjinrxs](https://github.com/nihonjinrxs))
- Update db/structure.sql to current state after all these merges [\#34](https://github.com/hurricane-response/florence-api/pull/34) ([nihonjinrxs](https://github.com/nihonjinrxs))
- Adding missing semicolons in sql [\#32](https://github.com/hurricane-response/florence-api/pull/32) ([omnilord](https://github.com/omnilord))

## [2.5.0](https://github.com/hurricane-response/florence-api/tree/2.5.0) (2018-09-16)
**Closed issues:**

- Enable "Shelters Needing Updates" as a JSON endpoint [\#26](https://github.com/hurricane-response/florence-api/issues/26)
- Fix default sort in "Shelters Needing Updates" view to show most outdated first [\#25](https://github.com/hurricane-response/florence-api/issues/25)
- Make `state` field visible in "Shelters Needing Updates" view [\#24](https://github.com/hurricane-response/florence-api/issues/24)
- Should be able to add/update State when updating or adding shelter [\#11](https://github.com/hurricane-response/florence-api/issues/11)
- API Search Box only returns county results [\#10](https://github.com/hurricane-response/florence-api/issues/10)
- Update dev getting started docs [\#9](https://github.com/hurricane-response/florence-api/issues/9)
- Accepting field should read "True, False, Not available"  [\#8](https://github.com/hurricane-response/florence-api/issues/8)
- Change "Special Needs" checkbox to text input [\#5](https://github.com/hurricane-response/florence-api/issues/5)
- Add CEDR logo  [\#3](https://github.com/hurricane-response/florence-api/issues/3)
- Update instructions for Florence including calling script  [\#2](https://github.com/hurricane-response/florence-api/issues/2)

**Merged pull requests:**

- Fix API importer for dev use [\#30](https://github.com/hurricane-response/florence-api/pull/30) ([nihonjinrxs](https://github.com/nihonjinrxs))
- "Shelters Needing Updates" view fixes [\#28](https://github.com/hurricane-response/florence-api/pull/28) ([nihonjinrxs](https://github.com/nihonjinrxs))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
