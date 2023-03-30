/* ****************************************************************************
* $Revision: 74359 $:
* $Author: tanawat.wongjan $:
* $Date: 2020-07-20 16:16:20 +0700 (Mon, 20 Jul 2020) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Applications%20Core%20Attachment%20Entities%20-%20Manage%20Attachment%20Entities.sql $:
* $Id: Manage Applications Core Attachment Entities - Manage Attachment Entities.sql 74359 2020-07-20 09:16:20Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT FndDocumentVlEO.ENTITY_NAME AS RES_ENTITY_NAME
,FndDocumentVlEO.USER_ENTITY_NAME  AS RES_USER_ENTITY_NAME
,(SELECT USER_MODULE_NAME
	FROM FND_APPL_TAXONOMY_VL
	WHERE MODULE_ID = FndDocumentVlEO.MODULE_ID
	)                                AS RES_MODULE
,FndDocumentVlEO.DATA_OBJECT_CODE AS RES_DATABASE_RESOURCE
,FndDocumentVlEO.TABLE_NAME       AS RES_TABLE_NAME
,NVL((SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = FndDocumentVlEO.CATEGORY_SECURITY_ENABLED
	),'No') AS RES_ENABLE_SECURITY
,FndDocumentVlEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,FndDocumentVlEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,FndDocumentVlEO.CREATED_BY RSC_CREATED_BY
,FndDocumentVlEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_DOCUMENT_ENTITIES_VL FndDocumentVlEO
ORDER BY RES_ENTITY_NAME