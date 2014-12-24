  alter table BZ_CODE
  add constraint BZ_CODE_FK foreign key (CODESORTID)
  references BZ_CODESORT (CODESORTID) on delete set null;