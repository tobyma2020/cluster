function [components,cliques,CC] = k_clique(k,M)
% k-clique algorithm for detecting overlapping communities in a network 
% as defined in the paper "Uncovering the overlapping 
% community structure of complex networks in nature and society" - 
% G. Palla, I. Derényi, I. Farkas, and T. Vicsek - Nature 435, 814–818 (2005)
% 
% [X,Y,Z] = k_clique(k,A)
% 
% Inputs: 
% k - clique size 
% A - adjacency matrix
% 
% Outputs: 
% X - detected communities 
% Y - all cliques (i.e. complete subgraphs that are not parts of larger
% complete subgraphs)
% Z - k-clique matrix
%
% Author : Anh-Dung Nguyen
% Email : anh-dung.nguyen@isae.fr


% The adjacency matrix of the example network presented in the paper
% M = [1 1 0 0 0 0 0 0 0 1;
%     1 1 1 1 1 1 1 0 0 1;
%     0 1 1 1 0 0 1 0 0 0;
%     0 1 1 1 1 1 1 0 0 0;
%     0 1 0 1 1 1 1 1 0 0;
%     0 1 0 1 1 1 1 1 0 0;
%     0 1 1 1 1 1 1 1 1 1;
%     0 0 0 0 1 1 1 1 1 1;
%     0 0 0 0 0 0 1 1 1 1;
%     1 1 0 0 0 0 1 1 1 1];

nb_nodes = size(M,1); % number of nodes 

% Find the largest possible clique size via the degree sequence:
% Let {d1,d2,...,dk} be the degree sequence of a graph. The largest
% possible clique size of the graph is the maximum value k such that
% dk >= k-1
degree_sequence = sort(sum(M,2) - 1,'descend');
max_s = 0;
for i = 1:length(degree_sequence)
    if degree_sequence(i) >= i - 1
        max_s = i;
    else 
        break;
    end
end

cliques = cell(0);
% Find all s-size kliques in the graph
for s = max_s:-1:3
    M_aux = M;
    % Looping over nodes
    for n = 1:nb_nodes
        A = n; % Set of nodes all linked to each other
        B = setdiff(find(M_aux(n,:)==1),n); % Set of nodes that are linked to each node in A, but not necessarily to the nodes in B
        C = transfer_nodes(A,B,s,M_aux); % Enlarging A by transferring nodes from B
        if ~isempty(C)
            for i = size(C,1)
                cliques = [cliques;{C(i,:)}];
            end
        end
        M_aux(n,:) = 0; % Remove the processed node
        M_aux(:,n) = 0;
    end
end

% Generating the clique-clique overlap matrix
CC = zeros(length(cliques));
for c1 = 1:length(cliques)
    for c2 = c1:length(cliques)
        if c1==c2
            CC(c1,c2) = numel(cliques{c1});
        else
            CC(c1,c2) = numel(intersect(cliques{c1},cliques{c2}));
            CC(c2,c1) = CC(c1,c2);
        end
    end
end

% Extracting the k-clique matrix from the clique-clique overlap matrix
% Off-diagonal elements <= k-1 --> 0
% Diagonal elements <= k --> 0
CC(eye(size(CC))==1) = CC(eye(size(CC))==1) - k;
CC(eye(size(CC))~=1) = CC(eye(size(CC))~=1) - k + 1;
CC(CC >= 0) = 1;
CC(CC < 0) = 0;

% Extracting components (or k-clique communities) from the k-clique matrix
components = [];
for i = 1:length(cliques)
    linked_cliques = find(CC(i,:)==1);
    new_component = [];
    for j = 1:length(linked_cliques)
        new_component = union(new_component,cliques{linked_cliques(j)});
    end
    found = false;
    if ~isempty(new_component)
        for j = 1:length(components)
            if all(ismember(new_component,components{j}))
                found = true;
            end
        end
        if ~found
            components = [components; {new_component}];
        end
    end
end


    function R = transfer_nodes(S1,S2,clique_size,C)
        % Recursive function to transfer nodes from set B to set A (as
        % defined above)
        
        % Check if the union of S1 and S2 or S1 is inside an already found larger
        % clique 
        found_s12 = false;
        found_s1 = false;
        for c = 1:length(cliques)
            for cc = 1:size(cliques{c},1)
                if all(ismember(S1,cliques{c}(cc,:)))
                    found_s1 = true;
                end
                if all(ismember(union(S1,S2),cliques{c}(cc,:)))
                    found_s12 = true;
                    break;
                end
            end
        end
        
        if found_s12 || (length(S1) ~= clique_size && isempty(S2))
            % If the union of the sets A and B can be included in an
            % already found (larger) clique, the recursion is stepped back
            % to check other possibilities
            R = [];
        elseif length(S1) == clique_size;
            % The size of A reaches s, a new clique is found
            if found_s1
                R = [];
            else
                R = S1;
            end
        else
            % Check the remaining possible combinations of the neighbors
            % indices
            if isempty(find(S2>=max(S1),1))
                R = [];
            else
                R = [];
                for w = find(S2>=max(S1),1):length(S2)
                    S2_aux = S2;
                    S1_aux = S1;
                    S1_aux = [S1_aux S2_aux(w)];
                    S2_aux = setdiff(S2_aux(C(S2(w),S2_aux)==1),S2_aux(w));
                    R = [R;transfer_nodes(S1_aux,S2_aux,clique_size,C)];
                end
            end
        end
    end
end

