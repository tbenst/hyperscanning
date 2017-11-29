function val = cellMapReduce(myMap, myReduce, myCell)
    partial = cellfun(@(sub) myMap(sub), myCell, 'UniformOutput', false);
    val = myReduce(cell2mat(partial(:)));
end
