/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Applications%20Core%20Attachment%20Categories%20-%20Attachment%20Categories.sql $:
* $Id: Manage Applications Core Attachment Categories - Attachment Categories.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT FndDocumentCategoriesVlEO.CATEGORY_NAME AS RES_CATEGORY_NAME
,FndDocumentCategoriesVlEO.USER_NAME           AS RES_USER_NAME
,(SELECT USER_MODULE_NAME
	FROM FND_APPL_TAXONOMY_VL
	WHERE MODULE_ID = FndDocumentCategoriesVlEO.MODULE_ID
	)                                     AS RES_MODULE
,FndDocumentCategoriesVlEO.DESCRIPTION AS RES_DESCRIPTION
,FndDocumentCategoriesVlEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,FndDocumentCategoriesVlEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,FndDocumentCategoriesVlEO.CREATED_BY RSC_CREATED_BY
,FndDocumentCategoriesVlEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_DOCUMENT_CATEGORIES_VL FndDocumentCategoriesVlEO
ORDER BY RES_CATEGORY_NAME