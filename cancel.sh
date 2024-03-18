#!/bin/bash

for job_id in {40482810..40482842}
do
    scancel $job_id
done