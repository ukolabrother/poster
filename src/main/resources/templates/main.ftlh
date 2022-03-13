<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>


<@c.page>
    <div>
        <@l.logout />
        <span><a href="/user">user list</a> </span>
    </div>
    <div>
        <form method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <input type="text" name="text" placeholder="input post">
            <input type="text" name="tag" placeholder="tag">
            <button type="submit">add</button>
        </form>
        <form method="get" action="/main">
            <input type="text" name="filter" placeholder="search..." value="${filter}">
            <button type="submit">search</button>
        </form>
    </div>
    <div>List of posts</div>
    <#list posts as post>
        <div>
            <b>${post.id}</b>
            <span>${post.text}</span>
            <i>${post.tag}</i>
            <strong>${post.authorName}</strong>
        </div>
    <#else>
        no posts
    </#list>
</@c.page>