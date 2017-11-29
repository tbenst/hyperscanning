function rdm = RDM(response)
    temp = 1 - corr(response', 'type', 'spearman');
    rdm = temp/max(temp(:));
end
