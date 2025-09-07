import { NextResponse } from 'next/server';

const STRAPI_API_URL = process.env.STRAPI_API_URL || 'http://strapi:1337';

export async function GET() {
  try {
    const res = await fetch(
      `${STRAPI_API_URL}/api/posts?populate[image]=true&populate[category]=true`,
      { cache: 'no-store' }
    );

    if (!res.ok) {
      return NextResponse.json({ error: `HTTP error ${res.status}` }, { status: res.status });
    }

    const data = await res.json();
    return NextResponse.json(data);
  } catch (err: any) {
    return NextResponse.json({ error: err.message }, { status: 500 });
  }
}