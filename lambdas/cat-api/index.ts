import got from 'got';

export const handler = async (event, context, callback) => {
    console.log('Received event', event);

    const api_response = await got('https://swapi.dev/api/people/1/');

    console.log('Api Response', api_response.body)

    const response = {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
        'body': api_response.body,
        "isBase64Encoded": false
    }



    return response;
}