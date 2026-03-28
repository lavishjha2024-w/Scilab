clear;
clc;
// =====================================================
//        HYBRID TOPOLOGY (BUS + STAR + MESH)
// =====================================================
// ====================== BUS TOPOLOGY ======================
Bus_Start = [1 2 3 4 5 6 7 1 2 3 4 5 6 7];
Bus_End   = [2 3 4 5 6 7 8 9 10 11 12 13 14 15];
Bus_X = [100 100 100 100 100 100 100 100 200 300 400 500 600 300 300];
Bus_Y = [300 400 500 600 700 800 900 950 300 400 500 600 700 800 900];
// ====================== STAR TOPOLOGY =====================
// Node numbers will be offset (+15) → star nodes = 16–24
Star_Start = 15 + [2 3 4 5 6 7 8 9];
Star_End   = 15 + [1 1 1 1 1 1 1 1];
Star_X = [500 500 500 200 200 200 800 800 800];
Star_Y = [500 200 800 800 200 500 200 500 800];
// ====================== MESH TOPOLOGY =====================
// Node numbers offset (+24) → mesh nodes = 25–30
Mesh_Start = 24 + [2 3 4 5 6 2 3 4 5 6 2 3 4 5 6 2 3 4 5 6 2 3 4 5 6 2 3 4 5 6];
Mesh_End   = 24 + [1 1 1 1 1 2 2 2 2 2 3 3 3 3 3 4 4 4 4 4 5 5 5 5 5 6 6 6 6 6];
Mesh_X = [300 300 400 500 500 400];
Mesh_Y = [500 700 800 700 500 400];
// ====================== MERGE TOPOLOGIES ======================
// Node Coordinates
Hybrid_X = [Bus_X Star_X Mesh_X];
Hybrid_Y = [Bus_Y Star_Y Mesh_Y];
// Edges
Hybrid_Start = [Bus_Start Star_Start Mesh_Start];
Hybrid_End   = [Bus_End   Star_End   Mesh_End];
// Total nodes
TotalNodes = 30;
NameOfNetwork = "Hybrid Topology (Bus + Star + Mesh)";
// ====================== CREATE GRAPH ======================
[HybridGraph] = NL_G_MakeGraph(NameOfNetwork, TotalNodes, Hybrid_Start, Hybrid_End, Hybrid_X, Hybrid_Y);
// ====================== VISUALIZE HYBRID ======================
WindowIndex = 1;
NL_G_ShowGraph(HybridGraph, WindowIndex);
xtitle("Hybrid Network (Bus + Star + Mesh)", "X", "Y");
// ====================== GRAPH WITH INDICES ======================
WindowIndex = 2;
NL_G_ShowGraphNE(HybridGraph, WindowIndex);
xtitle("Hybrid Graph with Node & Edge Indices", "X", "Y");
// ====================== NUMBER OF NODES & EDGES ======================
[HybridNodes, HybridEdges] = NL_G_GraphSize(HybridGraph);
disp("Total Nodes in Hybrid:", HybridNodes);
disp("Total Edges in Hybrid:", HybridEdges);
// ====================== EDGE LENGTHS ======================
[EdgeLength] = NL_G_EdgesLength(HybridGraph.node_x, HybridGraph.node_y, HybridGraph.head, HybridGraph.tail);
disp("Length of All Edges:", EdgeLength);
// ====================== EDGES OF A SPECIFIC NODE ======================
NodeIndex = 20;    // Example node (Star topology)
[EdgesOfNode] = NL_G_EdgesOfNode(HybridGraph, NodeIndex);
disp("Edges connected to Node 20:", EdgesOfNode);
// ====================== NODE DATA FIELDS ======================
[node_x,node_y,node_border,node_diameter,node_color,node_number] = NL_G_NodeDataFields(HybridGraph);
disp("Node X:", node_x);
disp("Node Y:", node_y);
disp("Node Borders:", node_border);
disp("Node Diameter:", node_diameter);
disp("Node Color:", node_color);
disp("Node Numbers:", node_number);
// ====================== EDGE DATA FIELDS ======================
[e_head,e_tail,e_color,e_width,e_length,e_weight,e_number] = NL_G_EdgeDataFields(HybridGraph);
disp("Edge Heads:", e_head);
disp("Edge Tails:", e_tail);
disp("Edge Colors:", e_color);
disp("Edge Width:", e_width);
disp("Edge Length:", e_length);
disp("Edge Weight:", e_weight);
disp("Edge Numbers:", e_number);


