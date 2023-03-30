/* ****************************************************************************
* $Revision: 72658 $:
* $Author: tanawat.wongjan $:
* $Date: 2019-10-01 15:00:45 +0700 (Tue, 01 Oct 2019) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20SCM%20Common%20Value%20Sets%20-%20Manage%20SCM%20Common%20Value%20Sets.sql $:
* $Id: Manage SCM Common Value Sets - Manage SCM Common Value Sets.sql 55804 2016-06-09 04:17:45Z wuttipong.thongvises
$:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=CMP_TCS_STMT_VL

SELECT statementsE0.NAME RES_STATEMENT_DEFINITION_NAME
/*,(SELECT NAME
    FROM CMP_TCS_CAT_VL
    WHERE CAT_ID = detailsE0.CAT_ID
	) PARENTS*/
,detailsE0.DISPLAY_NAME RES_DISPLAY_NAME
,detailsE0.DESCRIPTION RES_DESCRIPTION
,statementsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,statementsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,statementsE0.CREATED_BY RSC_CREATED_BY
,statementsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CMP_TCS_STMT_VL statementsE0
,(SELECT CAT_ID
    ,SUBCAT_ID
    ,STMT_ID
    ,ORDR_NUM
    ,DISPLAY_NAME
    ,DESCRIPTION
    ,LEVEL LV
    ,CONNECT_BY_ROOT STMT_ID STMT_ID1
    FROM CMP_TCS_ROW_IN_CAT_VL
    START WITH STMT_ID IS NOT NULL
    CONNECT BY NOCYCLE PRIOR SUBCAT_ID = CAT_ID
    ) detailsE0
WHERE statementsE0.STMT_ID = detailsE0.STMT_ID1
ORDER BY statementsE0.NAME
,LV
,ORDR_NUM