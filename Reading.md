# Main Header

## 3.4 Barycentric Coordinates (page 46 of the book)

Barycentric coordinates essentilly turn any points inside a convex triangle using the cooridiantes of the vertex.

Any pointPin the plane of the points can then be uniquelyexpressed asP=uA+vB+wC for some constants u, v, and w, where the sum is one.

Actually two parameters are enough to parameterize the point `P` in the triangle.

The paramteres could be solved using Cramer's rule, essentailly solving a linear system.

This concept can also be tested aginst any simplex (tetrahedron, etc.).

The barycentric coordinates w.r.t. a triangle can be computed as ratios of areas.

> pecifically, the barycentric coor-dinates of a given pointPcan be computed as the ratios of the triangle areas ofPBC,PCA, andPABwith respect to the area of the entire triangleABC.
> Another way of looking at barycentriccoordinates is therefore as the componentsu,v, andwcorresponding to the nor-malized height of the pointPover each of the edgesBC,AC, andABrelative to theheight of the edge’s opposing vertex.

The coordinates remain invariant under projection.

## 7.* Spatial Partitioning (page 285)

By diving space into regions and testing if objects overlaps the same regions of space. They can __only__ intersect if they are in the same space.

### 7.1 Uniform grid

Divide them into a spave with regular grid of the same size. 

Problems arise with different cell size and cell complexity.
> Having objects overlap only a small number of cells is important
As this will reduce the amount of time for comparing the intersection of the cells.
> With cell size selected, grid dimensions are determined by dividing the diameterof the simulation space by the diameter of the cells.
> In ray tracing a popular method for determining the grid dimensions has been then1/3rule: givennobjects, divide space into ak×k×kgrid, withk=n1/3.The ratio ofcells to objects is referred to as thegrid density.

__Storing objects as a array of linked lists__

Another idea is to store the grid with a hashed table, mapping a 2D grid into a hash bucket. Problems w.r.t. hashing.

### Implicit storing

In 2D cases, the objects are now stored with 2 arrays corresponding to the columns and the rows. Testing for intersection can be done with comparsion of...

### 7.2 HGrid

Using grids with different sizes 

## Paper Parellel

For sampling:
1. Fast computation
2. Good blue noise properties

How to measure/validate blue noise properties
> radial meansand  anisotropy  of  the  Fourier  power  spectrum

What is the spectral mesh basis ?

### Background

__Blue Noise Sampling__: 
> A blue noise distribution refers to a sample set that has a uniform and unbiased distribution in the spatialdomain as well as absence of low frequency noise and structuredbias in the frequency domain. Due to its desirable spatial and spectral properties, blue noise sampling has been widely employed andreceived  significant  research  attentio

__Surface sampling__:
One of techniques for blue noise sample worth noticing. Many methods exist relies on pre-computed data. This method introduced is bothe parellel and 

Some notes on __quality__ and __mesh laplacian and spectral basis__

### Parallel Uniform Sampling on Surfaces

I guess dart sampling is the reference/benchmark for the generation quality.

Here they propose a parallel dart throwing algorithm for efficient Poisson disk sampling on surfaces. Only consider __triangler__ mesh surfaces.

> Using3D as an example: their algorithm starts by partitioning the domain (unit cube) into grid cells (voxel) of esize $r/\sqrt(3)$, thus the diagonal ofeach cell is $r$.

Cells are separated by a distance of at least r to achieve parallesim. (phase group)

### 3.1 Sampling with Euclidean Disttance

Compute a large set of inital random points by uniform and then partition these to grid cells and finally draw Poisson disk samples from the pointes contained in each cell,

1. Generate uniform points in a triangler mesh
    * Repeatedly select a triangle with probablity proportioanl to its area using barycentric coordinates u= 1−√ξ1,v=ξ2√ξ1.Hereξ1,ξ2∈[0,1] generated from uniform distribution
    * Storing each point's position, id and barycentri in a 1D array.
    * Apply stratified sampling, 
    > which budgets a certain number of samples per group oftriangles

2. With the uniformly generated points, triangle mesh is no longed needed.

> all we need isa generator that provides uniform random (i.e. white noise) sampleson the surface.

This is easy to finish

3. Grid partition into grids cell

Build a 3D grid around the boudngin box of all those points generated above 

Assign the cell ID.  

Using a global sorting to sort the poiints 

A cell is valid if theris is > 1 points. 

Phase group can be groued by: simply sorting all valid cells by their phase group ID
 ncreasing the number of phase groupswill help reduce sampling bias, but it also reduces the number ofcells per phase group, thus decreasing parallelism



See the pseudo-code in the paper
