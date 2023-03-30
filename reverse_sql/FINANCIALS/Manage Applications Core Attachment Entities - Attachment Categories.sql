/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Applications%20Core%20Attachment%20Entities%20-%20Attachment%20Categories.sql $:
* $Id: Manage Applications Core Attachment Entities - Attachment Categories.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT (SELECT ENTITY_NAME
	FROM FND_DOCUMENT_ENTITIES_VL
	WHERE DOCUMENT_ENTITY_ID = FndDocCategoriesToEntitiesEO.DOCUMENT_ENTITY_ID
	) AS RES_ENTITY_NAME
,(SELECT USER_ENTITY_NAME
	FROM FND_DOCUMENT_ENTITIES_VL
	WHERE DOCUMENT_ENTITY_ID = FndDocCategoriesToEntitiesEO.DOCUMENT_ENTITY_ID
	) AS RES_USER_ENTITY_NAME
,(SELECT USER_MODULE_NAME
	FROM FND_APPL_TAXONOMY_VL
	WHERE MODULE_ID =
		(SELECT MODULE_ID
		FROM FND_DOCUMENT_CATEGORIES_VL
		WHERE CATEGORY_ID = FndDocCategoriesToEntitiesEO.CATEGORY_ID
		)
	) AS RES_MODULE
,(SELECT CATEGORY_NAME
	FROM FND_DOCUMENT_CATEGORIES_VL
	WHERE CATEGORY_ID = FndDocCategoriesToEntitiesEO.CATEGORY_ID
	) AS RES_CATEGORY_NAME
,(SELECT USER_NAME
	FROM FND_DOCUMENT_CATEGORIES_VL
	WHERE CATEGORY_ID = FndDocCategoriesToEntitiesEO.CATEGORY_ID
	) AS RES_DISPLAY_NAME
,(SELECT DESCRIPTION
	FROM FND_DOCUMENT_CATEGORIES_VL
	WHERE CATEGORY_ID = FndDocCategoriesToEntitiesEO.CATEGORY_ID
	) AS RES_DESCRIPTION
,FndDocCategoriesToEntitiesEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,FndDocCategoriesToEntitiesEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,FndDocCategoriesToEntitiesEO.CREATED_BY RSC_CREATED_BY
,FndDocCategoriesToEntitiesEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_DOC_CATEGORIES_TO_ENTITIES FndDocCategoriesToEntitiesEO
ORDER BY RES_ENTITY_NAME


