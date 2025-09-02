import { NextRequest, NextResponse } from "next/server";

type RouteContext = {
  params: Promise<{
    documentId: string;
  }>;
};
export async function POST(
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

    const strapiUrl = `${process.env.NEXT_PUBLIC_STRAPI_API_URL}/api/posts/${documentId}/unlike`;
    //console.log("strapiURL = ", strapiUrl)
    const res = await fetch(strapiUrl, {
      method: "POST",
      // cache:"no-store",
      headers: {
        "Content-Type": "application/json",
      },
      body: await request.text(),
    });

    const data = await res.json();
    console.log("АнЛайкнул")
    console.log("Сейчас лайков =", data.likes)
    
    return NextResponse.json(data, { status: res.status });
  } catch (err) {
    console.error("Proxy error:", err);
    return NextResponse.json(
      { error: "Failed to connect to Strapi" },
      { status: 500 }
    );
  }
}