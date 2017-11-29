function a = concatCellbyCell(a,n)
    for i=1:numel(a)
        a{i} = [a{i} n{i}]
    end
end
