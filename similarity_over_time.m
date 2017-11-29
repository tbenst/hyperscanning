load('/home/tyler/Dropbox/data/keren-tyler/PDtrustOT_Tyler/PDilemma_trust-IzzyOTandPeytonOT-07-21-2014_SPIKE.mat');

% only use first half of data (pre-oxytocin)
halfway_idx = find(diff(WordEventTS)>60);
halfway_time = WordEventTS(halfway_idx);

start_idx = find(WordCodes==9 & WordEventTS>halfway_time);
duplicate_start = find(diff(start_idx)==1);
start_idx(duplicate_start) = [];

end_idx = find(WordCodes==18 & WordEventTS>halfway_time);
duplicate_end = find(diff(end_idx)==1);
end_idx(duplicate_end) = [];

result_idx = find(WordCodes==70 & WordEventTS>halfway_time);
result_times = WordEventTS(result_idx);
nresults = size(result_times,1);
% if stopped during trial
% if size(start_idx)+1==size(end_idx)
%     start_idx = start_idx(1:end-1)
% end

start_size = size(start_idx,1);
end_size = size(end_idx,1);
ntrials = start_size;
% error_codes = [55 57]
assert(start_size==end_size);


bins = 0:0.5:halfway_time;
bins = halfway_time:0.5:WordEventTS(end_idx(end));
nbins = size(bins,2)

A = Spikes(1:48,:);
nonempty_A = find(~cellfun(@isempty,A));
a = cellfun(@(x) histcounts(x,bins), A(nonempty_A), 'UniformOutput', false);
a = cell2mat(a);
a_random = randi(2,size(a))-1;

B = Spikes(49:96,:);
nonempty_B = find(~cellfun(@isempty,B));
b = cellfun(@(x) histcounts(x,bins), B(nonempty_B), 'UniformOutput', false);
b = cell2mat(b);
b_random = randi(2,size(b))-1;

% time-series RSA
autocorrLag = 5;
autocorrLead = 5;
% only calculate valid for sliding window
start_t = 1 + autocorrLag;
end_t = nbins-1-autocorrLead;
similarity = zeros(nbins,1);
similarity_random = zeros(nbins,1);

for i = start_t:end_t
    s = i - autocorrLag;
    e = i+autocorrLead;
    if e>end_t
        break
    end

    similarity(s) = RSA(a(:,s:e), b(:,s:e));
    similarity_random(s) = RSA(a_random(:,s:e), b_random(:,s:e));
end
plot(bins, similarity)

max_s = max(similarity);
min_s = min(similarity);

% find bin of result presentation
hist_rt = find(histcounts(result_times,bins));
line(repmat(hist_rt,2,1),repmat([max_s; min_s],1,nresults), 'Color','red','LineStyle','--')
xlabel('time (s)')
ylabel('similarity [-1,1]')
legend('similarity', 'Results shown')

mean(similarity)
mean(similarity_random)

function similarity = RSA(responseA, responseB)
    % Representational Dissimilarity Matrix for both monkeys
    RDMa = corr(responseA, 'type', 'spearman');
    RDMb = corr(responseB, 'type', 'spearman');

    % Representational Similarity analysis to compare RDMs
    similarity = corr(reshape(RDMa,[],1), reshape(RDMb,[],1), 'type', 'spearman');
end
