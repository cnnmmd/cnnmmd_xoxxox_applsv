#!/bin/bash

pthtop="$(cd "$(dirname "${0}")/../../../.." && pwd)"
source "${pthtop}"/manage/lib/params.sh
source "${pthtop}"/manage/lib/shared.sh
source "${pthcrr}"/params.sh

pthapp="${pthsrc}"/applsv
pthprj="${pthapp}/llama.cpp"
cntapp='/opt/applsv'
cntprj="${cntapp}/llama.cpp"

addimg ${imgtgt} "${cnfimg}" "${pthdoc}"
test -d "${pthapp}" || mkdir "${pthapp}"
if cd "${pthapp}"
then
  test -d "${pthprj}" || git clone --depth 1 https://github.com/ggml-org/llama.cpp.git
fi

echo docker run -v "${pthapp}":"${cntapp}" --name ${cnttgt} ${imgtgt} /exp/runcfg.sh "${cntprj}" # DBG
docker run -v "${pthapp}":"${cntapp}" --name ${cnttgt} ${imgtgt} /exp/runcfg.sh "${cntprj}" && \
docker commit ${cnttgt} ${imgtgt} && \
docker stop ${cnttgt} && \
docker rm ${cnttgt}
