/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Profile%20Rating%20Models%20-%20Rating%20Categories.sql $:
 * $Id: Manage Profile Rating Models - Rating Categories.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT hrtRatingModelEO.RATING_MODEL_CODE RES_CODE
 ,hrtRatingModelEO.RATING_NAME RES_NAME
 ,hrtRatingCATEEO.CATEGORY_NAME RES_CATEGORY_NAME
 ,hrtRatingCATEEO.CATEGORY_DESCRIPTION RES_CATEGORY_DESCRIPTION
 ,hrtRatingCATEEO.LOWER_BOUNDARY RES_LOWER_BOUNDARY
 ,hrtRatingCATEEO.UPPER_BOUNDARY RES_UPPER_BOUNDARY
 ,hrtRatingCATEEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
 ,hrtRatingCATEEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
 ,hrtRatingCATEEO.CREATED_BY RSC_CREATED_BY
 ,hrtRatingCATEEO.CREATION_DATE RSC_CREATION_DATE
 ,NULL RSC_LEDGER_ID
 ,NULL RSC_CHART_OF_ACCOUNTS_ID
 ,NULL RSC_BUSINESS_UNIT_ID
 ,NULL RSC_LEGAL_ENTITY_ID
 ,NULL RSC_ORGANIZATION_ID
 ,hrtRatingModelEO.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
 ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRT_RATING_MODELS_VL hrtRatingModelEO
,HRT_RATING_CATEGORIES_VL hrtRatingCATEEO
WHERE hrtRatingModelEO.RATING_MODEL_ID = hrtRatingCATEEO.RATING_MODEL_ID
AND hrtRatingModelEO.BUSINESS_GROUP_ID = hrtRatingCATEEO.BUSINESS_GROUP_ID
ORDER BY hrtRatingModelEO.RATING_NAME
