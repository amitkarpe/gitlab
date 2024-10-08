FROM chainguard/conda:latest-dev

LABEL authors="leila@lifebit.ai" \
    description="Docker image containing FUSION, for more info see: http://gusevlab.org/projects/fusion/" \
    name="quay.io/lifebitaiorg/twas" \
    version="1.0"


# Update Conda and initialize it for the shell
RUN conda init && \
    conda config --add channels conda-forge && \
    conda config --add channels r && \
    conda install -y bash \
    r-optparse \
    r-rcolorbrewer \
    dnachun::r-plink2r\
    dnachun::fusion_twas && \
    conda clean -a


ENTRYPOINT [""]
