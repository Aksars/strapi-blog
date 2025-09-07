import { NextRequest, NextResponse } from "next/server";

const STRAPI_API_URL = process.env.STRAPI_API_URL || 'http://strapi:1337';

type RouteContext = {
  params: Promise<{
    documentId: string;
  }>;
};
export async function GET(
  request: NextRequest,
  context: RouteContext
) {
  try {
   const { documentId } = await context.params;
    
    if (!documentId) {
      return NextResponse.json(
        { error: "Document ID is required" },
        { status: 400 }
      );
    }

    const res = await fetch(
      `${STRAPI_API_URL}/api/posts/${documentId}/`,
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

