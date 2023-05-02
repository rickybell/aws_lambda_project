import got from 'got';

export const handler = async (event, context) => {
    console.log('Received event', event);

    try {
        const response = await got('https://swapi.dev/api/people/1/');
        console.log(response.body)
        return {
            status: 200,
            body: response.body
        }
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
}