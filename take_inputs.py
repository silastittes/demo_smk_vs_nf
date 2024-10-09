import argparse
import sys


def parse_args(args):
    
    parser = argparse.ArgumentParser(
        description="""Example script for demo
        """
    )
     
    parser.add_argument(
        "-o",
        "--output_file",
        type=str,
        required=True,
        help="""Name of the fasta input file to process
        """,
    ),
    parser.add_argument(
        "-s",
        "--seed",
        type=int,
        required=True,
        help="""Value of random seed
        """,
    )

    return parser.parse_args(args)


if __name__ == "__main__":

    args = parse_args(sys.argv[1:])

    with open(args.output_file, 'w') as f:
        print(args.seed, file = f)
