/*
 * -----------------------------------------------------------------------------
 * @(#)Entity.java
 * @version    1.0
 * -----------------------------------------------------------------------------
 * Copyright 2004 by DongYang Information Service Co., Ltd.
 * Information Technology Group, Research and Development Group,
 * Technology support Part.
 * All rights reserved.
 * -----------------------------------------------------------------------------
 * NOTICE! You can copy or redistribute this code freely,
 * but you should not remove the information about the copyright notice
 * and the author.
 * -----------------------------------------------------------------------------
 */
package egovframework.com.cmm;

import java.io.Serializable;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;
import java.util.Set;
import java.util.Vector;


/**
 * <p>DTO Entity.</p>
 * @version  1.0
 */
public class Entity extends HashMap implements Serializable {
    
    /**
     *
     * @param sKey String
     * @param sValue String
     */
    public void setValue(String sKey, String sValue) {
        if (sValue != null)
            put(sKey, sValue);
    }

    /**
     *
     * @param sKey String
     * @param sValues String[]
     */
    public void setValue(String sKey, String[] sValues) {
        put(sKey, sValues);
    }

    /**
     *
     * @param sKey String
     * @param yValue byte
     */
    public void setValue(String sKey, byte yValue) {
        put(sKey, Byte.toString(yValue));
    }

    /**
     *
     * @param sKey String
     * @param yValues byte[]
     */
    public void setValue(String sKey, byte[] yValues) {
        String sValue = null;

        if (yValues != null)
            sValue = new String(yValues);

        put(sKey, sValue);
    }

    /**
     *
     * @param sKey String
     * @param cValue char
     */
    public void setValue(String sKey, char cValue) {
        put(sKey, String.valueOf(cValue));
    }

    /**
     *
     * @param sKey String
     * @param cValues char[]
     */
    public void setValue(String sKey, char[] cValues) {
        String sValue = null;

        if (cValues != null)
            sValue = new String(cValues);

        put(sKey, sValue);
    }

    /**
     *
     * @param sKey String
     * @param fValue float
     */
    public void setValue(String sKey, float fValue) {
        put(sKey, String.valueOf(fValue));
    }

    /**
     *
     * @param sKey String
     * @param bValue boolean
     */
    public void setValue(String sKey, boolean bValue) {
        put(sKey, String.valueOf(bValue));
    }

    /**
     *
     * @param sKey String
     * @param tValue short
     */
    public void setValue(String sKey, short tValue) {
        put(sKey, String.valueOf(tValue));
    }

    /**
     *
     * @param sKey String
     * @param iValue int
     */
    public void setValue(String sKey, int iValue) {
        put(sKey, String.valueOf(iValue));
    }

    /**
     *
     * @param sKey String
     * @param lValue long
     */
    public void setValue(String sKey, long lValue) {
        put(sKey, String.valueOf(lValue));
    }

    /**
     *
     * @param sKey String
     * @param dValue double
     */
    public void setValue(String sKey, double dValue) {
        put(sKey, String.valueOf(dValue));
    }

    /**
     *
     * @param sKey String
     * @param value Date
     */
    public void setValue(String sKey, java.util.Date value) {

        String sValue = null;

        if (value != null);
            sValue = value.toString();

        put(sKey, sValue);
    }

    /**
     *
     * @param sKey String
     * @param value Vector
     */
    public void setValue(String sKey, Vector value) {
        put(sKey, value);
    }

    /**
     *
     * @param sKey String
     * @param value ArrayList
     */
    public void setValue(String sKey, ArrayList value) {
        put(sKey, value);
    }

    /**
     *
     * @param sKey String
     * @param value Hashtable
     */
    public void setValue(String sKey, Hashtable value) {
        put(sKey, value);
    }

    /**
     *
     * @param sKey String
     * @param value Entity
     */
    public void setValue(String sKey, Entity value) {
        put(sKey, value);
    }

    /**
     *
     * @param sKey String
     * @param value HashMap
     */
    public void setValue(String sKey, HashMap value) {
        put(sKey, value);
    }

    /**
     *
     * @param sKey String
     * @param value Object
     */
    public void setValue(String sKey, Object value) {
        put(sKey, value);
    }

    /**
     *
     * @param sKey String
     * @return String
     */
    public String getString(String sKey) {
        try {
            Object obj = get(sKey);

            if (obj instanceof String)
                return (String) obj;
            else if (obj instanceof String[])
                return ((String[]) obj)[0];
            else
                return "";
        } catch (Exception e) { return ""; }
    }

    /**
     *
     * @param sKey String
     * @return String[]
     */
    public String[] getStrings(String sKey) {
        try {
            Object obj = get(sKey);

            if (obj instanceof String)
                return new String[] { (String) obj };
            else
                return (String[])obj;
        } catch (Exception e) { }

        return null;
    }

    /**
     *
     * @param sKey String
     * @return byte
     */
    public byte getByte(String sKey) {
        try {
            return Byte.parseByte((String)get(sKey));
        } catch (Exception e) { return (byte)0; }
    }

    /**
     *
     * @param sKey String
     * @return byte[]
     */
    public byte[] getBytes(String sKey) {
        try {
            return ((String)get(sKey)).getBytes();
        } catch (Exception e) { return null; }
    }

    /**
     *
     * @param sKey String
     * @return char
     */
    public char getChar(String sKey) {
        try {
            return ((String)get(sKey)).charAt(0);
        } catch (Exception e) { return (char)0; }
    }

    /**
     *
     * @param sKey String
     * @return char[]
     */
    public char[] getChars(String sKey) {
        try {
            return ((String)get(sKey)).toCharArray();
        } catch (Exception e) { return null; }
    }

    /**
     *
     * @param sKey String
     * @return float
     */
    public float getFloat(String sKey) {
        try {
            return Float.parseFloat((String)get(sKey));
        } catch (Exception e) { return 0; }
    }

    /**
     *
     * @param sKey String
     * @return boolean
     */
    public boolean getBoolean(String sKey) {
        try {
            String sVal = (String)get(sKey);

            return sVal.equals("true") ? true : sVal.equals("false") ? false : Boolean.getBoolean(sVal);
        } catch (Exception e) { return false; }
    }

    /**
     *
     * @param sKey String
     * @return short
     */
    public short getShort(String sKey) {
        try {
            return Short.parseShort((String)get(sKey));
        } catch (Exception e) { return 0; }
    }

    /**
     *
     * @param sKey String
     * @return int
     */
    public int getInt(String sKey) {
        try {
            return Integer.parseInt((String)get(sKey));
        } catch (Exception e) { return 0; }
    }

    /**
     *
     * @param sKey String
     * @return long
     */
    public long getLong(String sKey) {
        try {
            return Long.parseLong((String)get(sKey));
        } catch (Exception e) { return 0; }
    }

    /**
     *
     * @param sKey String
     * @return double
     */
    public double getDouble(String sKey) {
        try {
            return Double.parseDouble((String)get(sKey));
        } catch (Exception e) { return 0; }
    }

    /**
     *
     * @param sKey String
     * @return Date
     */
    public java.util.Date getDate(String sKey) {
        try {
            String sDate = (String)get(sKey);
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            ParsePosition pos = new ParsePosition(0);

            return formatter.parse(sDate, pos);
        } catch (Exception e) { return null; }
    }

    /**
     *
     * @param sKey String
     * @return Date
     */
    public java.util.Date getDate(String sKey, String sFormat) {
        try {
            String sDate = (String)get(sKey);
            SimpleDateFormat formatter = new SimpleDateFormat(sFormat);
            ParsePosition pos = new ParsePosition(0);

            return formatter.parse(sDate, pos);
        } catch (Exception e) { return null; }
    }

    /**
     *
     * @param sKey String
     * @return Vector
     */
    public Vector getVector(String sKey) {
        try {
            Vector vResult = (Vector)get(sKey);

            return vResult == null ? new Vector() : vResult;
        } catch (Exception e) { return new Vector(); }
    }

    /**
     *
     * @param sKey String
     * @return ArrayList
     */
    public ArrayList getArrayList(String sKey) {
        try {
            ArrayList vResult = (ArrayList)get(sKey);

            return vResult == null ? new ArrayList() : vResult;
        } catch (Exception e) { return new ArrayList(); }
    }

    /**
     *
     * @param sKey String
     * @return Hashtable
     */
    public Hashtable getHashtable(String sKey) {
        try {
            Hashtable vResult = (Hashtable)get(sKey);

            return vResult == null ? new Hashtable() : vResult;
        } catch (Exception e) { return new Hashtable(); }
    }

    /**
     *
     * @param sKey String
     * @return Entity
     */
    public Entity getEntity(String sKey) {
        try {
            Entity vResult = (Entity)get(sKey);

            return vResult == null ? new Entity() : vResult;
        } catch (Exception e) { return new Entity(); }
    }

    /**
     *
     * @param sKey String
     * @return HashMap
     */
    public HashMap getHashMap(String sKey) {
        try {
            HashMap vResult = (HashMap)get(sKey);

            return vResult == null ? new HashMap() : vResult;
        } catch (Exception e) { return new HashMap(); }
    }

    /**
     *
     * @param sKey String
     * @return Object
     */
    public Object getObject(String sKey) {
        try {
            Object vResult = get(sKey);

            return vResult == null ? new Object() : vResult;
        } catch (Exception e) { return new Object(); }
    }

    /**
     *
     * @param sValue String
     * @return String
     */
    public String getKey(String sValue) {
        Set keySet = entrySet();
        Object lists[] = keySet.toArray();
        int length = lists == null ? 0 : lists.length;

        String sKey = null;
        Object value = null;

        for (int i = 0; i < length; i++) {
            sKey = (String)(((Map.Entry)lists[i]).getKey());
            value = get(sKey);

            if (value instanceof String && ((String)value).trim().equals(sValue))
                return (String)sKey;
        }

        return null;
    }

    /**
     *
     * @param sValue String
     * @param sKeyPrefix String
     * @return String
     */
    public String getKey(String sValue, String sKeyPrefix) {
        sKeyPrefix = sKeyPrefix;

        Set keySet = entrySet();
        Object lists[] = keySet.toArray();
        int length = lists == null ? 0 : lists.length;

        String sKey = null;
        Object value = null;

        for (int i = 0; i < length; i++) {
            sKey = (String)(((Map.Entry)lists[i]).getKey());
            value = get(sKey);

            if (sKey.startsWith(sKeyPrefix) && value instanceof String && ((String)value).trim().equals(sValue))
                return (String)sKey;
        }

        return null;
    }

    /**
     *
     * @param sKey String
     */
    public void remove(String sKey) {
        super.remove(sKey);
    }

    /**
     *
     * @return int
     */
    public int size() {
        return super.size();
    }

    /**
     *
     */
    public void clear() {
        super.clear();
    }

    /**
     *
     * @return Object
     */
    public Object clone() {
        return super.clone();
    }
    
}
