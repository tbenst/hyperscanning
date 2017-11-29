function divergence  = KLdivergence(P, Q)
    divergence = KLdiv(P,Q) + KLdiv(Q,P);
end

function div = KLdiv(P,Q)
    div = integral(@(x) helper(x, P, Q),-Inf,Inf);
    % div = trapz(arrayfun(@(x) helper(x,P,Q), 1:100));
end

function y = helper(x, P, Q)
    px = pdf(P, x);
    qx = pdf(Q, x);
    if qx<1e-10
        qx = 1e-10;
    end
    y = px*log2(px/qx);
end
