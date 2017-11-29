function newCell = nonEmptyCell(myCell)
    nonempty = find(~cellfun(@isempty,myCell));
    newCell = myCell(nonempty);
end
