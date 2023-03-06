import boto3
import argparse
# I used this as my resource to get me started:
# https://boto3.amazonaws.com/v1/documentation/api/latest/guide/s3-example-creating-buckets.html

# This helped with the command line argument portion:
#  https://stackoverflow.com/questions/61291816/how-to-implement-argparse-in-python

parser = argparse.ArgumentParser(description="Provides translation between one source language and another of the same set of languages.")

# Add each of the arguments using the parser.add_argument() method
parser.add_argument(
    '--bucket',
    dest="bucket",
    type=str,
    help="Please provide the bucket name you wish to use.",
    required=True
    )

args = parser.parse_args()

s3_client = boto3.client('s3', region_name="us-west-2")
location = {'LocationConstraint': "us-west-2"}
s3_client.create_bucket(Bucket=args.bucket,
                        CreateBucketConfiguration=location)
