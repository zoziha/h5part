#include "H5Part.h"
#include "h5ptock.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

H5PartFile *file;
int numparticles = 1000;
int x_dim = 64;
int y_dim = 64;
int z_dim = 64;

void create_synthetic_h5part_data()
{
    printf("Writing out sample particle data");
    double *x, *y, *z;
    x = (double *)malloc(numparticles * sizeof(double));
    y = (double *)malloc(numparticles * sizeof(double));
    z = (double *)malloc(numparticles * sizeof(double));

    h5part_int64_t *id;
    id = (h5part_int64_t *)malloc(numparticles * sizeof(h5part_int64_t));

    int i;
    for (i = 0; i < numparticles; i++)
    {
        id[i] = i;
        x[i] = 1.0 * x_dim;
        y[i] = 2.0 * y_dim;
        z[i] = ((double)i / numparticles) * z_dim;
    }

    H5PartSetStep(file, 0); // only 1 timestep in this file
    H5PartSetNumParticles(file, numparticles);

    H5PartWriteDataFloat64(file, "x", x);
    H5PartWriteDataFloat64(file, "y", y);
    H5PartWriteDataFloat64(file, "z", z);

    H5PartWriteDataFloat64(file, "px", z);
    H5PartWriteDataFloat64(file, "py", z);
    H5PartWriteDataFloat64(file, "pz", z);

    H5PartWriteDataInt64(file, "id", id);

    free(x);
    free(y);
    free(z);
    free(id);
    printf("....\n");
}

void create_synthetic_h5ptock_data1()
{
    printf("Writing out sample field data1");
    h5part_float64_t *data;
    data = malloc(x_dim * y_dim * z_dim * sizeof(h5part_float64_t));
    int i, j, k;
    int index = 0;

    for (i = 0; i < x_dim; i++)
    {
        for (j = 0; j < y_dim; j++)
        {
            for (k = 0; k < z_dim; k++)
            {

                data[index] = (h5part_float64_t)index;
                index++;
            }
        }
    }

    h5ptockDefine3DFieldLayout(file, 0, (x_dim - 1), 0, (y_dim - 1), 0, (z_dim - 1));
    h5ptock3dWriteScalarFieldFloat64(file, "LinearField", data);

    h5part_float64_t origin = 0.0;
    h5part_float64_t spacing = 1.0;
    h5ptock3dSetFieldOrigin(file, "LinearField", origin, origin, origin);
    h5ptock3dSetFieldSpacing(file, "LinearField", spacing, spacing, spacing);

    free(data);
    printf(".\n");
}

void create_synthetic_h5ptock_data2()
{
    printf("Writing out sample field data2");

    int SIZE = x_dim;
    double mean = SIZE * 0.5;
    double stdDev = SIZE * 0.33;
    double scale = 1.0 / (stdDev * sqrt(2.0 * M_PI));
    double exponent;
    double divisor = 1.0 / (2.0 * stdDev * stdDev);

    int i, j, k, indx = 0;

    h5part_float64_t *dist = (h5part_float64_t *)calloc(SIZE, sizeof(h5part_float64_t));
    /* compute the 1D pdf */
    for (i = 0; i < SIZE; i++)
    {
        double x = (double)i;
        exponent = -1.0 * (x - mean) * (x - mean) * divisor;
        dist[i] = scale * exp(exponent);
    }

    h5part_float64_t *dest = (h5part_float64_t *)calloc(SIZE * SIZE * SIZE, sizeof(h5part_float64_t));
    /* the 3D PDF is the product of 3 1D PDFs */
    for (k = 0; k < SIZE; k++)
        for (j = 0; j < SIZE; j++)
            for (i = 0; i < SIZE; i++)
                dest[indx++] = dist[k] * dist[j] * dist[i];

    h5ptockDefine3DFieldLayout(file, 0, (SIZE - 1), 0, (SIZE - 1), 0, (SIZE - 1));
    h5ptock3dWriteScalarFieldFloat64(file, "GaussianField", dest);

    h5part_float64_t origin = 0.0;
    h5part_float64_t spacing = 1.0;
    h5ptock3dSetFieldOrigin(file, "GaussianField", origin, origin, origin);
    h5ptock3dSetFieldSpacing(file, "GaussianField", spacing, spacing, spacing);

    free(dist);
    free(dest);
    printf(".\n");
}

int main(int argc, char *argv[])
{

    file = H5PartOpenFile("./example/sample.h5part", H5PART_WRITE);

    H5PartWriteFileAttribString(file, "Origin", "Created by LBNL Visualization group");

    create_synthetic_h5part_data();

    create_synthetic_h5ptock_data1();
    create_synthetic_h5ptock_data2();

    H5PartCloseFile(file);

    return 0;
}