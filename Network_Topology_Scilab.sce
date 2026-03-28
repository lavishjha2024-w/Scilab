clear;
clc;

// =====================================================
// HYBRID TOPOLOGY (BUS + STAR + MESH)

// =====================================================

// ====================== BUS TOPOLOGY ======================
Bus_Start = [1 2 3 4 5 6 7 1 2 3 4 5 6 7];
Bus_End   = [2 3 4 5 6 7 8 9 10 11 12 13 14 15];

Bus_X = [100 100 100 100 100 100 100 100 200 300 400 500 600 300 300];
Bus_Y = [300 400 500 600 700 800 900 950 300 400 500 600 700 800 900];

// ====================== STAR TOPOLOGY ======================
Star_Start = 15 + [2 3 4 5 6 7 8 9];
Star_End   = 15 + [1 1 1 1 1 1 1 1];

Star_X = [500 500 500 200 200 200 800 800 800];
Star_Y = [500 200 800 800 200 500 200 500 800];

// ====================== MESH TOPOLOGY ======================
Mesh_Start = 24 + [2 3 4 5 6  2 3 4 5 6  2 3 4 5 6];
Mesh_End   = 24 + [1 1 1 1 1  2 2 2 2 2  3 3 4 4 5];

Mesh_X = [300 300 400 500 500 400];
Mesh_Y = [500 700 800 700 500 400];

// ====================== MERGE ======================
X = [Bus_X Star_X Mesh_X];
Y = [Bus_Y Star_Y Mesh_Y];

Start = [Bus_Start Star_Start Mesh_Start];
EndN  = [Bus_End   Star_End   Mesh_End];

TotalNodes = 30;

// ====================== DRAW GRAPH ======================
f = scf(0);
clf(f);
show_window(f);

// ---- FIX FIGURE SIZE (MATCH IMAGE) ----
f.figure_size = [1600, 600];   // wide canvas like screenshot

a = gca();
a.auto_clear = "off";

// ---- FIX AXIS LIMITS (CRITICAL) ----
a.data_bounds = [0 0; 1000 1000];   // EXACT grid scale
a.isoview = "on";                  // equal scaling

drawlater();

// ---- draw edges ----
for i = 1:length(Start)
    xpoly([X(Start(i)), X(EndN(i))], ...
          [Y(Start(i)), Y(EndN(i))]);
end

// ---- draw nodes ----
plot(X, Y, "ko");

// ---- label nodes ----
for i = 1:TotalNodes
    xstring(X(i)+12, Y(i)+12, string(i));
end

title("Hybrid Graph with Node & Edge Indices");
xlabel("X");
ylabel("Y");
xgrid();

drawnow();

// ====================== INFO ======================
disp("Total Nodes:");
disp(TotalNodes);

disp("Total Edges:");
disp(length(Start));


