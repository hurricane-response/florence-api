# Change Log

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

- Adding missing semicolons in sql [\#32](https://github.com/hurricane-response/florence-api/pull/32) ([omnilord](https://github.com/omnilord))
- Fix API importer for dev use [\#30](https://github.com/hurricane-response/florence-api/pull/30) ([nihonjinrxs](https://github.com/nihonjinrxs))
- "Shelters Needing Updates" view fixes [\#28](https://github.com/hurricane-response/florence-api/pull/28) ([nihonjinrxs](https://github.com/nihonjinrxs))
- Lots of README updates… [\#23](https://github.com/hurricane-response/florence-api/pull/23) ([nihonjinrxs](https://github.com/nihonjinrxs))
- \[DB Migration\] \[Depends on \#30\] Accessibility field [\#22](https://github.com/hurricane-response/florence-api/pull/22) ([nihonjinrxs](https://github.com/nihonjinrxs))
- \[DB migration\] Add third state "unknown" to accepting field on shelters [\#21](https://github.com/hurricane-response/florence-api/pull/21) ([nihonjinrxs](https://github.com/nihonjinrxs))
- Fix the contributors page to display contributors from the correct repo [\#20](https://github.com/hurricane-response/florence-api/pull/20) ([nihonjinrxs](https://github.com/nihonjinrxs))
- Add Export to CSV for shelters, both rake shelters:export and a button on index [\#18](https://github.com/hurricane-response/florence-api/pull/18) ([nihonjinrxs](https://github.com/nihonjinrxs))
- Fix footer to point to the florence repo instead of the harvey one. [\#17](https://github.com/hurricane-response/florence-api/pull/17) ([nihonjinrxs](https://github.com/nihonjinrxs))
- Add view of shelters needing updates. [\#16](https://github.com/hurricane-response/florence-api/pull/16) ([nihonjinrxs](https://github.com/nihonjinrxs))
- Add a State field in the Shelter update form [\#13](https://github.com/hurricane-response/florence-api/pull/13) ([nihonjinrxs](https://github.com/nihonjinrxs))
- Update README dev docs to re-order a few things [\#12](https://github.com/hurricane-response/florence-api/pull/12) ([nihonjinrxs](https://github.com/nihonjinrxs))
- Format timestamps as relative time in admin table [\#6](https://github.com/hurricane-response/florence-api/pull/6) ([tdooner](https://github.com/tdooner))
- Store record\_type for Draft posts [\#4](https://github.com/hurricane-response/florence-api/pull/4) ([tdooner](https://github.com/tdooner))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*