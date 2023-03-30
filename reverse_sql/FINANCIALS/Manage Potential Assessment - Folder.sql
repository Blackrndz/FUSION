/* ****************************************************************************
* $Revision: 71641 $:
* $Author: tanawat.wongjan $:
* $Date: 2019-03-18 14:02:24 +0700 (Mon, 18 Mar 2019) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Worker%20Time%20Entry%20Profiles%20-%20Worker%20View.sql $:
* $Id: Manage Worker Time Entry Profiles - Worker View.sql 71641 2019-03-18 07:02:24Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT (SELECT NAME
    FROM HRQ_CATEGORIES_VL
    WHERE CATEGORY_ID = foldersE0.PARENT_CATEGORY_ID
    ) RES_PARENT_FOLDER
,foldersE0.NAME RES_FOLDER
,foldersE0.CREATED_BY  AS RSC_CREATED_BY
,foldersE0.CREATION_DATE AS RSC_CREATION_DATE
,foldersE0.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,foldersE0.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,foldersE0.BUSINESS_GROUP_ID  RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM HRQ_CATEGORIES_VL foldersE0
START WITH foldersE0.CATEGORY_ID = 3
CONNECT BY PRIOR foldersE0.CATEGORY_ID = foldersE0.PARENT_CATEGORY_ID