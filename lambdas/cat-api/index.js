export const handler = async(event) => {
// export async function handler(event, context) {
    console.log('Received event', event);
    // console.log('Context', context);

    try {
        const response = {body: {message: "bingo"}};
        // const response = await got('https://aws.random.cat/meow');
        console.log(response.body)
         return {
            status : 200,
            body: response.body
         }
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
}