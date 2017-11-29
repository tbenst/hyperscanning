function newCell = nonNaNcell(myCell)
    nonNaNnonNon = find(cellfun(@(x) ~strictIsnan(x),myCell));
    newCell = myCell(nonNaNnonNon);
end
