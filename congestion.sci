clc;
clear;

// ---------------- DIJKSTRA FUNCTION
function d = dijkstra(A, src)

    n = size(A,1);
    visited = zeros(1,n);
    d = ones(1,n) * %inf;
    d(src) = 0;

    for i = 1:n

        minval = %inf;
        u = -1;

        for j = 1:n
            if visited(j) == 0 & d(j) < minval then
                minval = d(j);
                u = j;
            end
        end

        if u == -1 then
            break;
        end

        visited(u) = 1;

        for v = 1:n
            if A(u,v) <> 0 then
                if d(u) + A(u,v) < d(v) then
                    d(v) = d(u) + A(u,v);
                end
            end
        end

    end

endfunction


// ---------------- BELLMAN FORD FUNCTION
function d = bellmanford(A, src)

    n = size(A,1);
    d = ones(1,n) * %inf;
    d(src) = 0;

    for k = 1:n-1
        for i = 1:n
            for j = 1:n
                if A(i,j) <> 0 then
                    if d(i) + A(i,j) < d(j) then
                        d(j) = d(i) + A(i,j);
                    end
                end
            end
        end
    end

endfunction


// ---------------- MAIN PROGRAM

nodes = [];
time_dij = [];
time_bf = [];

k = 1;

for n = 5:5:100

    nodes(k) = n;

    // Create random weighted adjacency matrix
    A = round(rand(n,n)*10);
    A(A < 7) = 0;         
    A = triu(A,1);
    A = A + A';           

    src = 1;

    // -------- Dijkstra Timing
    td = [];
    for t = 1:5
        t1 = timer();
        d1 = dijkstra(A, src);
        td(t) = timer() - t1;
    end
    time_dij(k) = mean(td);

    // -------- Bellman-Ford Timing
    tb = [];
    for t = 1:5
        t2 = timer();
        d2 = bellmanford(A, src);
        tb(t) = timer() - t2;
    end
    time_bf(k) = mean(tb);

    // PRINT OUTPUT
    mprintf("Nodes = %d\n", n);
    mprintf("Dijkstra Time = %f seconds\n", time_dij(k));
    mprintf("Bellman-Ford Time = %f seconds\n", time_bf(k));
    mprintf("-----------------------------\n");

    k = k + 1;

end


// -------- PLOT RESULT

scf();
clf();

plot(nodes, time_dij, 'b-o');
plot(nodes, time_bf, 'r-*');

legend("Dijkstra","Bellman-Ford");

xlabel("Number of Nodes");
ylabel("Time (seconds)");
title("Routing Algorithm Time Comparison");

drawnow();

disp("Execution Completed Successfully.");
