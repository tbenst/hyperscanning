function rsa = RSA(rdmA, rdmB)
    rsa = corr(upperTriangle(rdmA), upperTriangle(rdmB), 'type', 'spearman');
end
